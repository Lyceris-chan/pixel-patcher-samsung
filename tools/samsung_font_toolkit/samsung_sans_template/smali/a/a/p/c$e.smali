.class public La/a/p/c$e;
.super La/a/o/d/j;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = La/a/p/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "e"
.end annotation


# instance fields
.field public final synthetic m:La/a/p/c;


# direct methods
.method public constructor <init>(La/a/p/c;Landroid/content/Context;La/a/o/d/f;Landroid/view/View;Z)V
    .locals 7

    iput-object p1, p0, La/a/p/c$e;->m:La/a/p/c;

    sget v5, La/a/a;->actionOverflowMenuStyle:I

    const/4 v6, 0x0

    move-object v0, p0

    move-object v1, p2

    move-object v2, p3

    move-object v3, p4

    move v4, p5

    .line 1
    invoke-direct/range {v0 .. v6}, La/a/o/d/j;-><init>(Landroid/content/Context;La/a/o/d/f;Landroid/view/View;ZII)V

    const p2, 0x800005

    .line 2
    iput p2, p0, La/a/o/d/j;->g:I

    .line 3
    iget-object p1, p1, La/a/p/c;->y:La/a/p/c$f;

    invoke-virtual {p0, p1}, La/a/o/d/j;->d(La/a/o/d/k$a;)V

    return-void
.end method


# virtual methods
.method public c()V
    .locals 2

    iget-object v0, p0, La/a/p/c$e;->m:La/a/p/c;

    .line 1
    iget-object v0, v0, La/a/o/d/b;->d:La/a/o/d/f;

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    .line 2
    invoke-virtual {v0, v1}, La/a/o/d/f;->c(Z)V

    .line 3
    :cond_0
    iget-object v0, p0, La/a/p/c$e;->m:La/a/p/c;

    const/4 v1, 0x0

    iput-object v1, v0, La/a/p/c;->u:La/a/p/c$e;

    invoke-super {p0}, La/a/o/d/j;->c()V

    return-void
.end method
