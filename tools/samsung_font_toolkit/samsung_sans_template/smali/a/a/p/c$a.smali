.class public La/a/p/c$a;
.super La/a/o/d/j;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = La/a/p/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "a"
.end annotation


# instance fields
.field public final synthetic m:La/a/p/c;


# direct methods
.method public constructor <init>(La/a/p/c;Landroid/content/Context;La/a/o/d/p;Landroid/view/View;)V
    .locals 7

    iput-object p1, p0, La/a/p/c$a;->m:La/a/p/c;

    sget v5, La/a/a;->actionOverflowMenuStyle:I

    const/4 v4, 0x0

    const/4 v6, 0x0

    move-object v0, p0

    move-object v1, p2

    move-object v2, p3

    move-object v3, p4

    .line 1
    invoke-direct/range {v0 .. v6}, La/a/o/d/j;-><init>(Landroid/content/Context;La/a/o/d/f;Landroid/view/View;ZII)V

    .line 2
    iget-object p2, p3, La/a/o/d/p;->B:La/a/o/d/g;

    .line 3
    invoke-virtual {p2}, La/a/o/d/g;->g()Z

    move-result p2

    if-nez p2, :cond_1

    iget-object p2, p1, La/a/p/c;->j:La/a/p/c$d;

    if-nez p2, :cond_0

    .line 4
    iget-object p2, p1, La/a/o/d/b;->i:La/a/o/d/l;

    .line 5
    check-cast p2, Landroid/view/View;

    .line 6
    :cond_0
    iput-object p2, p0, La/a/o/d/j;->f:Landroid/view/View;

    .line 7
    :cond_1
    iget-object p1, p1, La/a/p/c;->y:La/a/p/c$f;

    invoke-virtual {p0, p1}, La/a/o/d/j;->d(La/a/o/d/k$a;)V

    return-void
.end method


# virtual methods
.method public c()V
    .locals 2

    iget-object v0, p0, La/a/p/c$a;->m:La/a/p/c;

    const/4 v1, 0x0

    iput-object v1, v0, La/a/p/c;->v:La/a/p/c$a;

    const/4 v1, 0x0

    iput v1, v0, La/a/p/c;->z:I

    invoke-super {p0}, La/a/o/d/j;->c()V

    return-void
.end method
