.class public abstract La/a/o/d/c;
.super Ljava/lang/Object;
.source ""


# instance fields
.field public final a:Landroid/content/Context;

.field public b:La/b/f;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "La/b/f<",
            "La/c/f/a/b;",
            "Landroid/view/MenuItem;",
            ">;"
        }
    .end annotation
.end field

.field public c:La/b/f;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "La/b/f<",
            "La/c/f/a/c;",
            "Landroid/view/SubMenu;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, La/a/o/d/c;->a:Landroid/content/Context;

    return-void
.end method


# virtual methods
.method public final c(Landroid/view/MenuItem;)Landroid/view/MenuItem;
    .locals 3

    instance-of v0, p1, La/c/f/a/b;

    if-eqz v0, :cond_1

    move-object v0, p1

    check-cast v0, La/c/f/a/b;

    iget-object v1, p0, La/a/o/d/c;->b:La/b/f;

    if-nez v1, :cond_0

    new-instance v1, La/b/f;

    invoke-direct {v1}, La/b/f;-><init>()V

    iput-object v1, p0, La/a/o/d/c;->b:La/b/f;

    :cond_0
    iget-object v1, p0, La/a/o/d/c;->b:La/b/f;

    const/4 v2, 0x0

    .line 1
    invoke-virtual {v1, p1, v2}, La/b/f;->getOrDefault(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    .line 2
    check-cast p1, Landroid/view/MenuItem;

    if-nez p1, :cond_1

    new-instance p1, La/a/o/d/h;

    iget-object v1, p0, La/a/o/d/c;->a:Landroid/content/Context;

    invoke-direct {p1, v1, v0}, La/a/o/d/h;-><init>(Landroid/content/Context;La/c/f/a/b;)V

    iget-object v1, p0, La/a/o/d/c;->b:La/b/f;

    invoke-virtual {v1, v0, p1}, La/b/f;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    return-object p1
.end method

.method public final d(Landroid/view/SubMenu;)Landroid/view/SubMenu;
    .locals 2

    instance-of v0, p1, La/c/f/a/c;

    if-eqz v0, :cond_2

    check-cast p1, La/c/f/a/c;

    iget-object v0, p0, La/a/o/d/c;->c:La/b/f;

    if-nez v0, :cond_0

    new-instance v0, La/b/f;

    invoke-direct {v0}, La/b/f;-><init>()V

    iput-object v0, p0, La/a/o/d/c;->c:La/b/f;

    :cond_0
    iget-object v0, p0, La/a/o/d/c;->c:La/b/f;

    invoke-virtual {v0, p1}, La/b/f;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/SubMenu;

    if-nez v0, :cond_1

    new-instance v0, La/a/o/d/q;

    iget-object v1, p0, La/a/o/d/c;->a:Landroid/content/Context;

    invoke-direct {v0, v1, p1}, La/a/o/d/q;-><init>(Landroid/content/Context;La/c/f/a/c;)V

    iget-object v1, p0, La/a/o/d/c;->c:La/b/f;

    invoke-virtual {v1, p1, v0}, La/b/f;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    return-object v0

    :cond_2
    return-object p1
.end method
