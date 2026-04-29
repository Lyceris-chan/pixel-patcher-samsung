.class public La/a/p/k0;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field public final b:La/a/o/d/a;

.field public final synthetic c:La/a/p/l0;


# direct methods
.method public constructor <init>(La/a/p/l0;)V
    .locals 6

    iput-object p1, p0, La/a/p/k0;->c:La/a/p/l0;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance p1, La/a/o/d/a;

    iget-object v0, p0, La/a/p/k0;->c:La/a/p/l0;

    iget-object v0, v0, La/a/p/l0;->a:Landroidx/appcompat/widget/Toolbar;

    invoke-virtual {v0}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object v1

    iget-object v0, p0, La/a/p/k0;->c:La/a/p/l0;

    iget-object v5, v0, La/a/p/l0;->h:Ljava/lang/CharSequence;

    const/4 v2, 0x0

    const v3, 0x102002c

    const/4 v4, 0x0

    move-object v0, p1

    invoke-direct/range {v0 .. v5}, La/a/o/d/a;-><init>(Landroid/content/Context;IIILjava/lang/CharSequence;)V

    iput-object p1, p0, La/a/p/k0;->b:La/a/o/d/a;

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    iget-object p1, p0, La/a/p/k0;->c:La/a/p/l0;

    iget-object v0, p1, La/a/p/l0;->k:Landroid/view/Window$Callback;

    if-eqz v0, :cond_0

    iget-boolean p1, p1, La/a/p/l0;->l:Z

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    iget-object v1, p0, La/a/p/k0;->b:La/a/o/d/a;

    invoke-interface {v0, p1, v1}, Landroid/view/Window$Callback;->onMenuItemSelected(ILandroid/view/MenuItem;)Z

    :cond_0
    return-void
.end method
