.class public La/a/o/d/o$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = La/a/o/d/o;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation


# instance fields
.field public final synthetic b:La/a/o/d/o;


# direct methods
.method public constructor <init>(La/a/o/d/o;)V
    .locals 0

    iput-object p1, p0, La/a/o/d/o$a;->b:La/a/o/d/o;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onGlobalLayout()V
    .locals 2

    iget-object v0, p0, La/a/o/d/o$a;->b:La/a/o/d/o;

    invoke-virtual {v0}, La/a/o/d/o;->b()Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, La/a/o/d/o$a;->b:La/a/o/d/o;

    iget-object v1, v0, La/a/o/d/o;->j:La/a/p/z;

    .line 1
    iget-boolean v1, v1, La/a/p/x;->B:Z

    if-nez v1, :cond_2

    .line 2
    iget-object v0, v0, La/a/o/d/o;->o:Landroid/view/View;

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/view/View;->isShown()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, La/a/o/d/o$a;->b:La/a/o/d/o;

    iget-object v0, v0, La/a/o/d/o;->j:La/a/p/z;

    invoke-virtual {v0}, La/a/p/x;->h()V

    goto :goto_1

    :cond_1
    :goto_0
    iget-object v0, p0, La/a/o/d/o$a;->b:La/a/o/d/o;

    invoke-virtual {v0}, La/a/o/d/o;->d()V

    :cond_2
    :goto_1
    return-void
.end method
