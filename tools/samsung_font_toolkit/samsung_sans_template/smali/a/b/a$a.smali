.class public La/b/a$a;
.super La/b/e;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = La/b/a;->k()La/b/e;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "La/b/e<",
        "TK;TV;>;"
    }
.end annotation


# instance fields
.field public final synthetic d:La/b/a;


# direct methods
.method public constructor <init>(La/b/a;)V
    .locals 0

    iput-object p1, p0, La/b/a$a;->d:La/b/a;

    invoke-direct {p0}, La/b/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 1

    iget-object v0, p0, La/b/a$a;->d:La/b/a;

    invoke-virtual {v0}, La/b/f;->clear()V

    return-void
.end method

.method public b(II)Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, La/b/a$a;->d:La/b/a;

    iget-object v0, v0, La/b/f;->c:[Ljava/lang/Object;

    shl-int/lit8 p1, p1, 0x1

    add-int/2addr p1, p2

    aget-object p1, v0, p1

    return-object p1
.end method

.method public c()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "TK;TV;>;"
        }
    .end annotation

    iget-object v0, p0, La/b/a$a;->d:La/b/a;

    return-object v0
.end method

.method public d()I
    .locals 1

    iget-object v0, p0, La/b/a$a;->d:La/b/a;

    iget v0, v0, La/b/f;->d:I

    return v0
.end method

.method public e(Ljava/lang/Object;)I
    .locals 1

    iget-object v0, p0, La/b/a$a;->d:La/b/a;

    invoke-virtual {v0, p1}, La/b/f;->d(Ljava/lang/Object;)I

    move-result p1

    return p1
.end method

.method public f(Ljava/lang/Object;)I
    .locals 1

    iget-object v0, p0, La/b/a$a;->d:La/b/a;

    invoke-virtual {v0, p1}, La/b/f;->f(Ljava/lang/Object;)I

    move-result p1

    return p1
.end method

.method public g(Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TK;TV;)V"
        }
    .end annotation

    iget-object v0, p0, La/b/a$a;->d:La/b/a;

    invoke-virtual {v0, p1, p2}, La/b/f;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method public h(I)V
    .locals 1

    iget-object v0, p0, La/b/a$a;->d:La/b/a;

    invoke-virtual {v0, p1}, La/b/f;->h(I)Ljava/lang/Object;

    return-void
.end method

.method public i(ILjava/lang/Object;)Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(ITV;)TV;"
        }
    .end annotation

    iget-object v0, p0, La/b/a$a;->d:La/b/a;

    shl-int/lit8 p1, p1, 0x1

    add-int/lit8 p1, p1, 0x1

    .line 1
    iget-object v0, v0, La/b/f;->c:[Ljava/lang/Object;

    aget-object v1, v0, p1

    aput-object p2, v0, p1

    return-object v1
.end method
