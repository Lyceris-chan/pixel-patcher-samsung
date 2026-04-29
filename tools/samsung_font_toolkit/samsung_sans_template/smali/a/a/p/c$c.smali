.class public La/a/p/c$c;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = La/a/p/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "c"
.end annotation


# instance fields
.field public b:La/a/p/c$e;

.field public final synthetic c:La/a/p/c;


# direct methods
.method public constructor <init>(La/a/p/c;La/a/p/c$e;)V
    .locals 0

    iput-object p1, p0, La/a/p/c$c;->c:La/a/p/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, La/a/p/c$c;->b:La/a/p/c$e;

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, La/a/p/c$c;->c:La/a/p/c;

    .line 1
    iget-object v0, v0, La/a/o/d/b;->d:La/a/o/d/f;

    if-eqz v0, :cond_0

    .line 2
    iget-object v1, v0, La/a/o/d/f;->e:La/a/o/d/f$a;

    if-eqz v1, :cond_0

    invoke-interface {v1, v0}, La/a/o/d/f$a;->b(La/a/o/d/f;)V

    .line 3
    :cond_0
    iget-object v0, p0, La/a/p/c$c;->c:La/a/p/c;

    .line 4
    iget-object v0, v0, La/a/o/d/b;->i:La/a/o/d/l;

    .line 5
    check-cast v0, Landroid/view/View;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/view/View;->getWindowToken()Landroid/os/IBinder;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, La/a/p/c$c;->b:La/a/p/c$e;

    invoke-virtual {v0}, La/a/o/d/j;->f()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, La/a/p/c$c;->c:La/a/p/c;

    iget-object v1, p0, La/a/p/c$c;->b:La/a/p/c$e;

    iput-object v1, v0, La/a/p/c;->u:La/a/p/c$e;

    :cond_1
    iget-object v0, p0, La/a/p/c$c;->c:La/a/p/c;

    const/4 v1, 0x0

    iput-object v1, v0, La/a/p/c;->w:La/a/p/c$c;

    return-void
.end method
