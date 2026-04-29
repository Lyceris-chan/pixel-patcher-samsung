.class public La/a/p/i;
.super Ljava/lang/Object;
.source ""


# instance fields
.field public final a:Landroid/widget/ImageView;

.field public b:La/a/p/h0;

.field public c:La/a/p/h0;


# direct methods
.method public constructor <init>(Landroid/widget/ImageView;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, La/a/p/i;->a:Landroid/widget/ImageView;

    return-void
.end method


# virtual methods
.method public a()V
    .locals 8

    iget-object v0, p0, La/a/p/i;->a:Landroid/widget/ImageView;

    invoke-virtual {v0}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-static {v0}, La/a/p/r;->b(Landroid/graphics/drawable/Drawable;)V

    :cond_0
    if-eqz v0, :cond_d

    .line 1
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v2, 0x1

    const/16 v3, 0x15

    const/4 v4, 0x0

    if-le v1, v3, :cond_2

    :cond_1
    const/4 v1, 0x0

    goto :goto_0

    :cond_2
    if-ne v1, v3, :cond_1

    const/4 v1, 0x1

    :goto_0
    if-eqz v1, :cond_c

    .line 2
    iget-object v1, p0, La/a/p/i;->c:La/a/p/h0;

    if-nez v1, :cond_3

    new-instance v1, La/a/p/h0;

    invoke-direct {v1}, La/a/p/h0;-><init>()V

    iput-object v1, p0, La/a/p/i;->c:La/a/p/h0;

    :cond_3
    iget-object v1, p0, La/a/p/i;->c:La/a/p/h0;

    const/4 v5, 0x0

    .line 3
    iput-object v5, v1, La/a/p/h0;->a:Landroid/content/res/ColorStateList;

    iput-boolean v4, v1, La/a/p/h0;->d:Z

    iput-object v5, v1, La/a/p/h0;->b:Landroid/graphics/PorterDuff$Mode;

    iput-boolean v4, v1, La/a/p/h0;->c:Z

    .line 4
    iget-object v6, p0, La/a/p/i;->a:Landroid/widget/ImageView;

    .line 5
    sget v7, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v7, v3, :cond_4

    invoke-virtual {v6}, Landroid/widget/ImageView;->getImageTintList()Landroid/content/res/ColorStateList;

    move-result-object v6

    goto :goto_1

    :cond_4
    instance-of v7, v6, La/c/j/f;

    if-eqz v7, :cond_5

    check-cast v6, La/c/j/f;

    invoke-interface {v6}, La/c/j/f;->getSupportImageTintList()Landroid/content/res/ColorStateList;

    move-result-object v6

    goto :goto_1

    :cond_5
    move-object v6, v5

    :goto_1
    if-eqz v6, :cond_6

    .line 6
    iput-boolean v2, v1, La/a/p/h0;->d:Z

    iput-object v6, v1, La/a/p/h0;->a:Landroid/content/res/ColorStateList;

    :cond_6
    iget-object v6, p0, La/a/p/i;->a:Landroid/widget/ImageView;

    .line 7
    sget v7, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v7, v3, :cond_7

    invoke-virtual {v6}, Landroid/widget/ImageView;->getImageTintMode()Landroid/graphics/PorterDuff$Mode;

    move-result-object v5

    goto :goto_2

    :cond_7
    instance-of v3, v6, La/c/j/f;

    if-eqz v3, :cond_8

    check-cast v6, La/c/j/f;

    invoke-interface {v6}, La/c/j/f;->getSupportImageTintMode()Landroid/graphics/PorterDuff$Mode;

    move-result-object v5

    :cond_8
    :goto_2
    if-eqz v5, :cond_9

    .line 8
    iput-boolean v2, v1, La/a/p/h0;->c:Z

    iput-object v5, v1, La/a/p/h0;->b:Landroid/graphics/PorterDuff$Mode;

    :cond_9
    iget-boolean v3, v1, La/a/p/h0;->d:Z

    if-nez v3, :cond_b

    iget-boolean v3, v1, La/a/p/h0;->c:Z

    if-eqz v3, :cond_a

    goto :goto_3

    :cond_a
    const/4 v2, 0x0

    goto :goto_4

    :cond_b
    :goto_3
    iget-object v3, p0, La/a/p/i;->a:Landroid/widget/ImageView;

    invoke-virtual {v3}, Landroid/widget/ImageView;->getDrawableState()[I

    move-result-object v3

    invoke-static {v0, v1, v3}, La/a/p/f;->e(Landroid/graphics/drawable/Drawable;La/a/p/h0;[I)V

    :goto_4
    if-eqz v2, :cond_c

    return-void

    .line 9
    :cond_c
    iget-object v1, p0, La/a/p/i;->b:La/a/p/h0;

    if-eqz v1, :cond_d

    iget-object v2, p0, La/a/p/i;->a:Landroid/widget/ImageView;

    invoke-virtual {v2}, Landroid/widget/ImageView;->getDrawableState()[I

    move-result-object v2

    invoke-static {v0, v1, v2}, La/a/p/f;->e(Landroid/graphics/drawable/Drawable;La/a/p/h0;[I)V

    :cond_d
    return-void
.end method

.method public b()Z
    .locals 3

    iget-object v0, p0, La/a/p/i;->a:Landroid/widget/ImageView;

    invoke-virtual {v0}, Landroid/widget/ImageView;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x15

    if-lt v1, v2, :cond_0

    instance-of v0, v0, Landroid/graphics/drawable/RippleDrawable;

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method public c(Landroid/util/AttributeSet;I)V
    .locals 8

    iget-object v0, p0, La/a/p/i;->a:Landroid/widget/ImageView;

    invoke-virtual {v0}, Landroid/widget/ImageView;->getContext()Landroid/content/Context;

    move-result-object v0

    sget-object v1, La/a/j;->AppCompatImageView:[I

    const/4 v2, 0x0

    invoke-static {v0, p1, v1, p2, v2}, La/a/p/j0;->n(Landroid/content/Context;Landroid/util/AttributeSet;[III)La/a/p/j0;

    move-result-object v0

    iget-object v1, p0, La/a/p/i;->a:Landroid/widget/ImageView;

    invoke-virtual {v1}, Landroid/widget/ImageView;->getContext()Landroid/content/Context;

    move-result-object v2

    sget-object v3, La/a/j;->AppCompatImageView:[I

    .line 1
    iget-object v5, v0, La/a/p/j0;->b:Landroid/content/res/TypedArray;

    const/4 v7, 0x0

    move-object v4, p1

    move v6, p2

    .line 2
    invoke-static/range {v1 .. v7}, La/c/i/n;->m(Landroid/view/View;Landroid/content/Context;[ILandroid/util/AttributeSet;Landroid/content/res/TypedArray;II)V

    :try_start_0
    iget-object p1, p0, La/a/p/i;->a:Landroid/widget/ImageView;

    invoke-virtual {p1}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object p1

    const/4 p2, -0x1

    if-nez p1, :cond_0

    sget v1, La/a/j;->AppCompatImageView_srcCompat:I

    invoke-virtual {v0, v1, p2}, La/a/p/j0;->i(II)I

    move-result v1

    if-eq v1, p2, :cond_0

    iget-object p1, p0, La/a/p/i;->a:Landroid/widget/ImageView;

    invoke-virtual {p1}, Landroid/widget/ImageView;->getContext()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1, v1}, La/a/l/a/a;->b(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object v1, p0, La/a/p/i;->a:Landroid/widget/ImageView;

    invoke-virtual {v1, p1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    :cond_0
    if-eqz p1, :cond_1

    invoke-static {p1}, La/a/p/r;->b(Landroid/graphics/drawable/Drawable;)V

    :cond_1
    sget p1, La/a/j;->AppCompatImageView_tint:I

    invoke-virtual {v0, p1}, La/a/p/j0;->l(I)Z

    move-result p1

    const/16 v1, 0x15

    if-eqz p1, :cond_4

    iget-object p1, p0, La/a/p/i;->a:Landroid/widget/ImageView;

    sget v2, La/a/j;->AppCompatImageView_tint:I

    invoke-virtual {v0, v2}, La/a/p/j0;->b(I)Landroid/content/res/ColorStateList;

    move-result-object v2

    .line 3
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v3, v1, :cond_3

    invoke-virtual {p1, v2}, Landroid/widget/ImageView;->setImageTintList(Landroid/content/res/ColorStateList;)V

    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ne v2, v1, :cond_4

    invoke-virtual {p1}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v2

    if-eqz v2, :cond_4

    invoke-virtual {p1}, Landroid/widget/ImageView;->getImageTintList()Landroid/content/res/ColorStateList;

    move-result-object v3

    if-eqz v3, :cond_4

    invoke-virtual {v2}, Landroid/graphics/drawable/Drawable;->isStateful()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-virtual {p1}, Landroid/widget/ImageView;->getDrawableState()[I

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/graphics/drawable/Drawable;->setState([I)Z

    goto :goto_0

    :catchall_0
    move-exception p1

    goto :goto_3

    :cond_2
    :goto_0
    invoke-virtual {p1, v2}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    goto :goto_1

    :cond_3
    instance-of v3, p1, La/c/j/f;

    if-eqz v3, :cond_4

    check-cast p1, La/c/j/f;

    invoke-interface {p1, v2}, La/c/j/f;->setSupportImageTintList(Landroid/content/res/ColorStateList;)V

    .line 4
    :cond_4
    :goto_1
    sget p1, La/a/j;->AppCompatImageView_tintMode:I

    invoke-virtual {v0, p1}, La/a/p/j0;->l(I)Z

    move-result p1

    if-eqz p1, :cond_7

    iget-object p1, p0, La/a/p/i;->a:Landroid/widget/ImageView;

    sget v2, La/a/j;->AppCompatImageView_tintMode:I

    invoke-virtual {v0, v2, p2}, La/a/p/j0;->g(II)I

    move-result p2

    const/4 v2, 0x0

    invoke-static {p2, v2}, La/a/p/r;->c(ILandroid/graphics/PorterDuff$Mode;)Landroid/graphics/PorterDuff$Mode;

    move-result-object p2

    .line 5
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    if-lt v2, v1, :cond_6

    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->setImageTintMode(Landroid/graphics/PorterDuff$Mode;)V

    sget p2, Landroid/os/Build$VERSION;->SDK_INT:I

    if-ne p2, v1, :cond_7

    invoke-virtual {p1}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object p2

    if-eqz p2, :cond_7

    invoke-virtual {p1}, Landroid/widget/ImageView;->getImageTintList()Landroid/content/res/ColorStateList;

    move-result-object v1

    if-eqz v1, :cond_7

    invoke-virtual {p2}, Landroid/graphics/drawable/Drawable;->isStateful()Z

    move-result v1

    if-eqz v1, :cond_5

    invoke-virtual {p1}, Landroid/widget/ImageView;->getDrawableState()[I

    move-result-object v1

    invoke-virtual {p2, v1}, Landroid/graphics/drawable/Drawable;->setState([I)Z

    :cond_5
    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    goto :goto_2

    :cond_6
    instance-of v1, p1, La/c/j/f;

    if-eqz v1, :cond_7

    check-cast p1, La/c/j/f;

    invoke-interface {p1, p2}, La/c/j/f;->setSupportImageTintMode(Landroid/graphics/PorterDuff$Mode;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 6
    :cond_7
    :goto_2
    iget-object p1, v0, La/a/p/j0;->b:Landroid/content/res/TypedArray;

    invoke-virtual {p1}, Landroid/content/res/TypedArray;->recycle()V

    return-void

    :goto_3
    iget-object p2, v0, La/a/p/j0;->b:Landroid/content/res/TypedArray;

    invoke-virtual {p2}, Landroid/content/res/TypedArray;->recycle()V

    .line 7
    throw p1
.end method

.method public d(I)V
    .locals 1

    if-eqz p1, :cond_1

    iget-object v0, p0, La/a/p/i;->a:Landroid/widget/ImageView;

    invoke-virtual {v0}, Landroid/widget/ImageView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0, p1}, La/a/l/a/a;->b(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-static {p1}, La/a/p/r;->b(Landroid/graphics/drawable/Drawable;)V

    :cond_0
    iget-object v0, p0, La/a/p/i;->a:Landroid/widget/ImageView;

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    goto :goto_0

    :cond_1
    iget-object p1, p0, La/a/p/i;->a:Landroid/widget/ImageView;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    :goto_0
    invoke-virtual {p0}, La/a/p/i;->a()V

    return-void
.end method

.method public e(Landroid/content/res/ColorStateList;)V
    .locals 1

    iget-object v0, p0, La/a/p/i;->b:La/a/p/h0;

    if-nez v0, :cond_0

    new-instance v0, La/a/p/h0;

    invoke-direct {v0}, La/a/p/h0;-><init>()V

    iput-object v0, p0, La/a/p/i;->b:La/a/p/h0;

    :cond_0
    iget-object v0, p0, La/a/p/i;->b:La/a/p/h0;

    iput-object p1, v0, La/a/p/h0;->a:Landroid/content/res/ColorStateList;

    const/4 p1, 0x1

    iput-boolean p1, v0, La/a/p/h0;->d:Z

    invoke-virtual {p0}, La/a/p/i;->a()V

    return-void
.end method

.method public f(Landroid/graphics/PorterDuff$Mode;)V
    .locals 1

    iget-object v0, p0, La/a/p/i;->b:La/a/p/h0;

    if-nez v0, :cond_0

    new-instance v0, La/a/p/h0;

    invoke-direct {v0}, La/a/p/h0;-><init>()V

    iput-object v0, p0, La/a/p/i;->b:La/a/p/h0;

    :cond_0
    iget-object v0, p0, La/a/p/i;->b:La/a/p/h0;

    iput-object p1, v0, La/a/p/h0;->b:Landroid/graphics/PorterDuff$Mode;

    const/4 p1, 0x1

    iput-boolean p1, v0, La/a/p/h0;->c:Z

    invoke-virtual {p0}, La/a/p/i;->a()V

    return-void
.end method
