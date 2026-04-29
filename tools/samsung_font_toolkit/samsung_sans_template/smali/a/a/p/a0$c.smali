.class public La/a/p/a0$c;
.super La/b/d;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = La/a/p/a0;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "c"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "La/b/d<",
        "Ljava/lang/Integer;",
        "Landroid/graphics/PorterDuffColorFilter;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>(I)V
    .locals 0

    invoke-direct {p0, p1}, La/b/d;-><init>(I)V

    return-void
.end method
