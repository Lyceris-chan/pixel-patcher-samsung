.class public La/a/p/e;
.super Ljava/lang/Object;
.source ""


# instance fields
.field public final a:Landroid/view/View;

.field public final b:La/a/p/f;

.field public c:I

.field public d:La/a/p/h0;

.field public e:La/a/p/h0;

.field public f:La/a/p/h0;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, -0x1

    iput v0, p0, La/a/p/e;->c:I

    iput-object p1, p0, La/a/p/e;->a:Landroid/view/View;

    invoke-static {}, La/a/p/f;->a()La/a/p/f;

    move-result-object p1

    iput-object p1, p0, La/a/p/e;->b:La/a/p/f;

    return-void
.end method


# virtual methods
.method public a()V
    .locals 8

    iget-object v0, p0, La/a/p/e;->a:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    if-eqz v0, :cond_b

    .line 1
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x15

    const/4 v3, 0x1

    const/4 v4, 0x0

    if-le v1, v2, :cond_1

    iget-object v1, p0, La/a/p/e;->d:La/a/p/h0;

    if-eqz v1, :cond_0

    :goto_0
    const/4 v1, 0x1

    goto :goto_1

    :cond_0
    const/4 v1, 0x0

    goto :goto_1

    :cond_1
    if-ne v1, v2, :cond_0

    goto :goto_0

    :goto_1
    if-eqz v1, :cond_9

    .line 2
    iget-object v1, p0, La/a/p/e;->f:La/a/p/h0;

    if-nez v1, :cond_2

    new-instance v1, La/a/p/h0;

    invoke-direct {v1}, La/a/p/h0;-><init>()V

    iput-object v1, p0, La/a/p/e;->f:La/a/p/h0;

    :cond_2
    iget-object v1, p0, La/a/p/e;->f:La/a/p/h0;

    const/4 v5, 0x0

    .line 3
    iput-object v5, v1, La/a/p/h0;->a:Landroid/content/res/ColorStateList;

    iput-boolean v4, v1, La/a/p/h0;->d:Z

    iput-object v5, v1, La/a/p/h0;->b:Landroid/graphics/PorterDuff$Mode;

    iput-boolean v4, v1, La/a/p/h0;->c:Z

    .line 4
    iget-object v6, p0, La/a/p/e;->a:Landroid/view/View;

    invoke-static {v6}, La/c/i/n;->c(Landroid/view/View;)Landroid/content/res/ColorStateList;

    move-result-object v6

    if-eqz v6, :cond_3

    iput-boolean v3, v1, La/a/p/h0;->d:Z

    iput-object v6, v1, La/a/p/h0;->a:Landroid/content/res/ColorStateList;

    :cond_3
    iget-object v6, p0, La/a/p/e;->a:Landroid/view/View;

    .line 5
    sget v7, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v7, v2, :cond_4

    invoke-virtual {v6}, Landroid/view/View;->getBackgroundTintMode()Landroid/graphics/PorterDuff$Mode;

    move-result-object v5

    goto :goto_2

    :cond_4
    instance-of v2, v6, La/c/i/j;

    if-eqz v2, :cond_5

    check-cast v6, La/c/i/j;

    invoke-interface {v6}, La/c/i/j;->getSupportBackgroundTintMode()Landroid/graphics/PorterDuff$Mode;

    move-result-object v5

    :cond_5
    :goto_2
    if-eqz v5, :cond_6

    .line 6
    iput-boolean v3, v1, La/a/p/h0;->c:Z

    iput-object v5, v1, La/a/p/h0;->b:Landroid/graphics/PorterDuff$Mode;

    :cond_6
    iget-boolean v2, v1, La/a/p/h0;->d:Z

    if-nez v2, :cond_8

    iget-boolean v2, v1, La/a/p/h0;->c:Z

    if-eqz v2, :cond_7

    goto :goto_3

    :cond_7
    const/4 v3, 0x0

    goto :goto_4

    :cond_8
    :goto_3
    iget-object v2, p0, La/a/p/e;->a:Landroid/view/View;

    invoke-virtual {v2}, Landroid/view/View;->getDrawableState()[I

    move-result-object v2

    invoke-static {v0, v1, v2}, La/a/p/f;->e(Landroid/graphics/drawable/Drawable;La/a/p/h0;[I)V

    :goto_4
    if-eqz v3, :cond_9

    return-void

    .line 7
    :cond_9
    iget-object v1, p0, La/a/p/e;->e:La/a/p/h0;

    if-eqz v1, :cond_a

    iget-object v2, p0, La/a/p/e;->a:Landroid/view/View;

    invoke-virtual {v2}, Landroid/view/View;->getDrawableState()[I

    move-result-object v2

    invoke-static {v0, v1, v2}, La/a/p/f;->e(Landroid/graphics/drawable/Drawable;La/a/p/h0;[I)V

    goto :goto_5

    :cond_a
    iget-object v1, p0, La/a/p/e;->d:La/a/p/h0;

    if-eqz v1, :cond_b

    iget-object v2, p0, La/a/p/e;->a:Landroid/view/View;

    invoke-virtual {v2}, Landroid/view/View;->getDrawableState()[I

    move-result-object v2

    invoke-static {v0, v1, v2}, La/a/p/f;->e(Landroid/graphics/drawable/Drawable;La/a/p/h0;[I)V

    :cond_b
    :goto_5
    return-void
.end method

.method public b()Landroid/content/res/ColorStateList;
    .locals 1

    iget-object v0, p0, La/a/p/e;->e:La/a/p/h0;

    if-eqz v0, :cond_0

    iget-object v0, v0, La/a/p/h0;->a:Landroid/content/res/ColorStateList;

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method

.method public c()Landroid/graphics/PorterDuff$Mode;
    .locals 1

    iget-object v0, p0, La/a/p/e;->e:La/a/p/h0;

    if-eqz v0, :cond_0

    iget-object v0, v0, La/a/p/h0;->b:Landroid/graphics/PorterDuff$Mode;

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method

.method public d(Landroid/util/AttributeSet;I)V
    .locals 10

    iget-object v0, p0, La/a/p/e;->a:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    sget-object v1, La/a/j;->ViewBackgroundHelper:[I

    const/4 v2, 0x0

    invoke-static {v0, p1, v1, p2, v2}, La/a/p/j0;->n(Landroid/content/Context;Landroid/util/AttributeSet;[III)La/a/p/j0;

    move-result-object v0

    iget-object v3, p0, La/a/p/e;->a:Landroid/view/View;

    invoke-virtual {v3}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v4

    sget-object v5, La/a/j;->ViewBackgroundHelper:[I

    .line 1
    iget-object v7, v0, La/a/p/j0;->b:Landroid/content/res/TypedArray;

    const/4 v9, 0x0

    move-object v6, p1

    move v8, p2

    .line 2
    invoke-static/range {v3 .. v9}, La/c/i/n;->m(Landroid/view/View;Landroid/content/Context;[ILandroid/util/AttributeSet;Landroid/content/res/TypedArray;II)V

    :try_start_0
    sget p1, La/a/j;->ViewBackgroundHelper_android_background:I

    invoke-virtual {v0, p1}, La/a/p/j0;->l(I)Z

    move-result p1

    const/4 p2, -0x1

    if-eqz p1, :cond_0

    sget p1, La/a/j;->ViewBackgroundHelper_android_background:I

    invoke-virtual {v0, p1, p2}, La/a/p/j0;->i(II)I

    move-result p1

    iput p1, p0, La/a/p/e;->c:I

    iget-object p1, p0, La/a/p/e;->b:La/a/p/f;

    iget-object v1, p0, La/a/p/e;->a:Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    iget v3, p0, La/a/p/e;->c:I

    invoke-virtual {p1, v1, v3}, La/a/p/f;->c(Landroid/content/Context;I)Landroid/content/res/ColorStateList;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-virtual {p0, p1}, La/a/p/e;->g(Landroid/content/res/ColorStateList;)V

    :cond_0
    sget p1, La/a/j;->ViewBackgroundHelper_backgroundTint:I

    invoke-virtual {v0, p1}, La/a/p/j0;->l(I)Z

    move-result p1

    const/4 v1, 0x1

    const/16 v3, 0x15

    if-eqz p1, :cond_5

    iget-object p1, p0, La/a/p/e;->a:Landroid/view/View;

    sget v4, La/a/j;->ViewBackgroundHelper_backgroundTint:I

    invoke-virtual {v0, v4}, La/a/p/j0;->b(I)Landroid/content/res/ColorStateList;

    move-result-object v4

    .line 3
    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v5, v3, :cond_4

    invoke-virtual {p1, v4}, Landroid/view/View;->setBackgroundTintList(Landroid/content/res/ColorStateList;)V

    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ne v4, v3, :cond_5

    invoke-virtual {p1}, Landroid/view/View;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v4

    invoke-virtual {p1}, Landroid/view/View;->getBackgroundTintList()Landroid/content/res/ColorStateList;

    move-result-object v5

    if-nez v5, :cond_2

    invoke-virtual {p1}, Landroid/view/View;->getBackgroundTintMode()Landroid/graphics/PorterDuff$Mode;

    move-result-object v5

    if-eqz v5, :cond_1

    goto :goto_0

    :cond_1
    const/4 v5, 0x0

    goto :goto_1

    :cond_2
    :goto_0
    const/4 v5, 0x1

    :goto_1
    if-eqz v4, :cond_5

    if-eqz v5, :cond_5

    invoke-virtual {v4}, Landroid/graphics/drawable/Drawable;->isStateful()Z

    move-result v5

    if-eqz v5, :cond_3

    invoke-virtual {p1}, Landroid/view/View;->getDrawableState()[I

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/graphics/drawable/Drawable;->setState([I)Z

    goto :goto_2

    :catchall_0
    move-exception p1

    goto :goto_5

    :cond_3
    :goto_2
    invoke-virtual {p1, v4}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    goto :goto_3

    :cond_4
    instance-of v5, p1, La/c/i/j;

    if-eqz v5, :cond_5

    check-cast p1, La/c/i/j;

    invoke-interface {p1, v4}, La/c/i/j;->setSupportBackgroundTintList(Landroid/content/res/ColorStateList;)V

    .line 4
    :cond_5
    :goto_3
    sget p1, La/a/j;->ViewBackgroundHelper_backgroundTintMode:I

    invoke-virtual {v0, p1}, La/a/p/j0;->l(I)Z

    move-result p1

    if-eqz p1, :cond_a

    iget-object p1, p0, La/a/p/e;->a:Landroid/view/View;

    sget v4, La/a/j;->ViewBackgroundHelper_backgroundTintMode:I

    invoke-virtual {v0, v4, p2}, La/a/p/j0;->g(II)I

    move-result p2

    const/4 v4, 0x0

    invoke-static {p2, v4}, La/a/p/r;->c(ILandroid/graphics/PorterDuff$Mode;)Landroid/graphics/PorterDuff$Mode;

    move-result-object p2

    .line 5
    sget v4, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v4, v3, :cond_9

    invoke-virtual {p1, p2}, Landroid/view/View;->setBackgroundTintMode(Landroid/graphics/PorterDuff$Mode;)V

    sget p2, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ne p2, v3, :cond_a

    invoke-virtual {p1}, Landroid/view/View;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object p2

    invoke-virtual {p1}, Landroid/view/View;->getBackgroundTintList()Landroid/content/res/ColorStateList;

    move-result-object v3

    if-nez v3, :cond_6

    invoke-virtual {p1}, Landroid/view/View;->getBackgroundTintMode()Landroid/graphics/PorterDuff$Mode;

    move-result-object v3

    if-eqz v3, :cond_7

    :cond_6
    const/4 v2, 0x1

    :cond_7
    if-eqz p2, :cond_a

    if-eqz v2, :cond_a

    invoke-virtual {p2}, Landroid/graphics/drawable/Drawable;->isStateful()Z

    move-result v1

    if-eqz v1, :cond_8

    invoke-virtual {p1}, Landroid/view/View;->getDrawableState()[I

    move-result-object v1

    invoke-virtual {p2, v1}, Landroid/graphics/drawable/Drawable;->setState([I)Z

    :cond_8
    invoke-virtual {p1, p2}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    goto :goto_4

    :cond_9
    instance-of v1, p1, La/c/i/j;

    if-eqz v1, :cond_a

    check-cast p1, La/c/i/j;

    invoke-interface {p1, p2}, La/c/i/j;->setSupportBackgroundTintMode(Landroid/graphics/PorterDuff$Mode;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 6
    :cond_a
    :goto_4
    iget-object p1, v0, La/a/p/j0;->b:Landroid/content/res/TypedArray;

    invoke-virtual {p1}, Landroid/content/res/TypedArray;->recycle()V

    return-void

    :goto_5
    iget-object p2, v0, La/a/p/j0;->b:Landroid/content/res/TypedArray;

    invoke-virtual {p2}, Landroid/content/res/TypedArray;->recycle()V

    .line 7
    throw p1
.end method

.method public e()V
    .locals 1

    const/4 v0, -0x1

    iput v0, p0, La/a/p/e;->c:I

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, La/a/p/e;->g(Landroid/content/res/ColorStateList;)V

    invoke-virtual {p0}, La/a/p/e;->a()V

    return-void
.end method

.method public f(I)V
    .locals 2

    iput p1, p0, La/a/p/e;->c:I

    iget-object v0, p0, La/a/p/e;->b:La/a/p/f;

    if-eqz v0, :cond_0

    iget-object v1, p0, La/a/p/e;->a:Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v0, v1, p1}, La/a/p/f;->c(Landroid/content/Context;I)Landroid/content/res/ColorStateList;

    move-result-object p1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    :goto_0
    invoke-virtual {p0, p1}, La/a/p/e;->g(Landroid/content/res/ColorStateList;)V

    invoke-virtual {p0}, La/a/p/e;->a()V

    return-void
.end method

.method public g(Landroid/content/res/ColorStateList;)V
    .locals 1

    if-eqz p1, :cond_1

    iget-object v0, p0, La/a/p/e;->d:La/a/p/h0;

    if-nez v0, :cond_0

    new-instance v0, La/a/p/h0;

    invoke-direct {v0}, La/a/p/h0;-><init>()V

    iput-object v0, p0, La/a/p/e;->d:La/a/p/h0;

    :cond_0
    iget-object v0, p0, La/a/p/e;->d:La/a/p/h0;

    iput-object p1, v0, La/a/p/h0;->a:Landroid/content/res/ColorStateList;

    const/4 p1, 0x1

    iput-boolean p1, v0, La/a/p/h0;->d:Z

    goto :goto_0

    :cond_1
    const/4 p1, 0x0

    iput-object p1, p0, La/a/p/e;->d:La/a/p/h0;

    :goto_0
    invoke-virtual {p0}, La/a/p/e;->a()V

    return-void
.end method

.method public h(Landroid/content/res/ColorStateList;)V
    .locals 1

    iget-object v0, p0, La/a/p/e;->e:La/a/p/h0;

    if-nez v0, :cond_0

    new-instance v0, La/a/p/h0;

    invoke-direct {v0}, La/a/p/h0;-><init>()V

    iput-object v0, p0, La/a/p/e;->e:La/a/p/h0;

    :cond_0
    iget-object v0, p0, La/a/p/e;->e:La/a/p/h0;

    iput-object p1, v0, La/a/p/h0;->a:Landroid/content/res/ColorStateList;

    const/4 p1, 0x1

    iput-boolean p1, v0, La/a/p/h0;->d:Z

    invoke-virtual {p0}, La/a/p/e;->a()V

    return-void
.end method

.method public i(Landroid/graphics/PorterDuff$Mode;)V
    .locals 1

    iget-object v0, p0, La/a/p/e;->e:La/a/p/h0;

    if-nez v0, :cond_0

    new-instance v0, La/a/p/h0;

    invoke-direct {v0}, La/a/p/h0;-><init>()V

    iput-object v0, p0, La/a/p/e;->e:La/a/p/h0;

    :cond_0
    iget-object v0, p0, La/a/p/e;->e:La/a/p/h0;

    iput-object p1, v0, La/a/p/h0;->b:Landroid/graphics/PorterDuff$Mode;

    const/4 p1, 0x1

    iput-boolean p1, v0, La/a/p/h0;->c:Z

    invoke-virtual {p0}, La/a/p/e;->a()V

    return-void
.end method
