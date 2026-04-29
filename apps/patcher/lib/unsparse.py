#!/usr/bin/env python3
"""
Pure-Python Android Sparse Image unsparser.

Converts Android sparse ext4 images (.img) into raw images that can be read 
by tools like 7-Zip, without requiring root or mount commands.
"""

import sys
import struct
import shutil
import os
from typing import Optional

# Sparse image magic number (0xED26FF3A)
MAGIC = 0xED26FF3A
SPARSE_HEADER_STRUCT = "<I4H4I"  # magic, major, minor, file_hdr_sz, chunk_hdr_sz, blk_sz, total_blks, total_chunks, image_checksum
CHUNK_HEADER_STRUCT = "<2H2I"    # chunk_type, reserved, chunk_sz, total_sz

# Chunk types
CHUNK_TYPE_RAW = 0xCAC1
CHUNK_TYPE_FILL = 0xCAC2
CHUNK_TYPE_DONT_CARE = 0xCAC3
CHUNK_TYPE_CRC32 = 0xCAC4

def unsparse(sparse_file: str, raw_file: str) -> bool:
    """
    Convert a sparse image to a raw image.
    
    Args:
        sparse_file: Path to the input sparse .img file
        raw_file: Path to the output raw .img file
        
    Returns:
        bool: True if successful, False otherwise
    """
    try:
        with open(sparse_file, "rb") as f:
            header_data = f.read(struct.calcsize(SPARSE_HEADER_STRUCT))
            if len(header_data) < struct.calcsize(SPARSE_HEADER_STRUCT):
                print(f"Error: {sparse_file} is too small to be a sparse image.")
                return False
                
            magic, major, minor, file_hdr_sz, chunk_hdr_sz, blk_sz, total_blks, total_chunks, image_checksum = \
                struct.unpack(SPARSE_HEADER_STRUCT, header_data)
            
            if magic != MAGIC:
                print(f"Warning: {sparse_file} is not a valid Android sparse image (magic mismatch).")
                # Check if it's already raw (ext4 magic at offset 1080)
                f.seek(1080)
                ext4_magic = f.read(2)
                if ext4_magic == b'\x53\xef':
                    print("This looks like a raw ext4 image. Copying...")
                else:
                    print("Treating as raw file and copying.")
                
                f.seek(0)
                with open(raw_file, "wb") as out:
                    shutil.copyfileobj(f, out)
                return True

            if major != 1:
                print(f"Error: Unknown major version {major}")
                return False

            print(f"Unsparsing {os.path.basename(sparse_file)}...")
            print(f"  Block size: {blk_sz}, Total blocks: {total_blks}, Total chunks: {total_chunks}")
            
            # Seek to start of first chunk
            if file_hdr_sz > struct.calcsize(SPARSE_HEADER_STRUCT):
                f.seek(file_hdr_sz - struct.calcsize(SPARSE_HEADER_STRUCT), os.SEEK_CUR)

            with open(raw_file, "wb") as out:
                for i in range(total_chunks):
                    chunk_header_data = f.read(chunk_hdr_sz)
                    if len(chunk_header_data) < 12:
                        print(f"Error: Incomplete chunk header at chunk {i}")
                        return False

                    chunk_type, reserved1, chunk_sz, total_sz = struct.unpack("<2H2I", chunk_header_data[:12])
                    
                    if chunk_hdr_sz > 12:
                        f.seek(chunk_hdr_sz - 12, os.SEEK_CUR)
                        
                    data_sz = total_sz - chunk_hdr_sz
                    output_sz = chunk_sz * blk_sz

                    if chunk_type == CHUNK_TYPE_RAW:
                        if data_sz != output_sz:
                            print(f"Error: Raw chunk input size ({data_sz}) does not match output size ({output_sz})")
                            return False
                        out.write(f.read(data_sz))
                    elif chunk_type == CHUNK_TYPE_FILL:
                        if data_sz != 4:
                            print(f"Error: Fill chunk size mismatch at chunk {i}")
                            return False
                        fill_data = f.read(4)
                        # Optimized fill
                        out.write(fill_data * (output_sz // 4))
                    elif chunk_type == CHUNK_TYPE_DONT_CARE:
                        # Skip data in output
                        out.seek(output_sz, os.SEEK_CUR)
                    elif chunk_type == CHUNK_TYPE_CRC32:
                        f.seek(4, os.SEEK_CUR)
                    else:
                        print(f"Error: Unknown chunk type 0x{chunk_type:04X} at chunk {i}")
                        return False
                        
                # Ensure the file is the correct total size
                out.truncate(total_blks * blk_sz)
                
            print(f"✅ Successfully converted to {raw_file}")
            return True
            
    except Exception as e:
        print(f"❌ Error unsparsing image: {e}")
        if os.path.exists(raw_file):
            os.remove(raw_file)
        return False

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: unsparse.py <sparse_img> <output_img>")
    else:
        unsparse(sys.argv[1], sys.argv[2])
