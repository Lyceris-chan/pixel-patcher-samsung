.class public La/a/p/c$f;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements La/a/o/d/k$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = La/a/p/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "f"
.end annotation


# instance fields
.field public final synthetic a:La/a/p/c;


# direct methods
.method public constructor <init>(La/a/p/c;)V
    .locals 0

    iput-object p1, p0, La/a/p/c$f;->a:La/a/p/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(La/a/o/d/f;Z)V
    .locals 2

    instance-of v0, p1, La/a/o/d/p;

    if-eqz v0, :cond_0

    invoke-virtual {p1}, La/a/o/d/f;->j()La/a/o/d/f;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, La/a/o/d/f;->c(Z)V

    :cond_0
    iget-object v0, p0, La/a/p/c$f;->a:La/a/p/c;

    .line 1
    iget-object v0, v0, La/a/o/d/b;->f:La/a/o/d/k$a;

    if-eqz v0, :cond_1

    .line 2
    invoke-interface {v0, p1, p2}, La/a/o/d/k$a;->a(La/a/o/d/f;Z)V

    :cond_1
    return-void
.end method

.method public b(La/a/o/d/f;)Z
    .locals 3

    iget-object v0, p0, La/a/p/c$f;->a:La/a/p/c;

    .line 1
    iget-object v1, v0, La/a/o/d/b;->d:La/a/o/d/f;

    const/4 v2, 0x0

    if-ne p1, v1, :cond_0

    return v2

    .line 2
    :cond_0
    move-object v1, p1

    check-cast v1, La/a/o/d/p;

    .line 3
    iget-object v1, v1, La/a/o/d/p;->B:La/a/o/d/g;

    .line 4
    iget v1, v1, La/a/o/d/g;->a:I

    .line 5
    iget-object v0, v0, La/a/o/d/b;->f:La/a/o/d/k$a;

    if-eqz v0, :cond_1

    .line 6
    invoke-interface {v0, p1}, La/a/o/d/k$a;->b(La/a/o/d/f;)Z

    move-result v2

    :cond_1
    return v2
.end method
