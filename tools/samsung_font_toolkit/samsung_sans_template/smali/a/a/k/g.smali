.class public La/a/k/g;
.super La/a/k/a;
.source ""

# interfaces
.implements Landroidx/appcompat/widget/ActionBarOverlayLayout$d;


# static fields
.field public static final n:Landroid/view/animation/Interpolator;

.field public static final o:Landroid/view/animation/Interpolator;


# instance fields
.field public a:Landroidx/appcompat/widget/ActionBarOverlayLayout;

.field public b:Landroidx/appcompat/widget/ActionBarContainer;

.field public c:Landroid/view/View;

.field public d:I

.field public e:Z

.field public f:Z

.field public g:Z

.field public h:Z

.field public i:La/a/o/c;

.field public j:Z

.field public final k:La/c/i/q;

.field public final l:La/c/i/q;

.field public final m:La/c/i/s;


# direct methods
.method public static constructor <clinit>()V
    .locals 1

    new-instance v0, Landroid/view/animation/AccelerateInterpolator;

    invoke-direct {v0}, Landroid/view/animation/AccelerateInterpolator;-><init>()V

    sput-object v0, La/a/k/g;->n:Landroid/view/animation/Interpolator;

    new-instance v0, Landroid/view/animation/DecelerateInterpolator;

    invoke-direct {v0}, Landroid/view/animation/DecelerateInterpolator;-><init>()V

    sput-object v0, La/a/k/g;->o:Landroid/view/animation/Interpolator;

    return-void
.end method


# virtual methods
.method public final a(Z)V
    .locals 8

    iget-boolean v0, p0, La/a/k/g;->f:Z

    iget-boolean v1, p0, La/a/k/g;->g:Z

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-eqz v1, :cond_0

    goto :goto_0

    :cond_0
    if-eqz v0, :cond_1

    const/4 v0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v0, 0x1

    :goto_1
    const-wide/16 v4, 0xfa

    const/4 v1, 0x2

    const/high16 v6, 0x3f800000    # 1.0f

    const/4 v7, 0x0

    if-eqz v0, :cond_c

    iget-boolean v0, p0, La/a/k/g;->h:Z

    if-nez v0, :cond_16

    iput-boolean v2, p0, La/a/k/g;->h:Z

    .line 1
    iget-object v0, p0, La/a/k/g;->i:La/a/o/c;

    if-eqz v0, :cond_2

    invoke-virtual {v0}, La/a/o/c;->a()V

    :cond_2
    iget-object v0, p0, La/a/k/g;->b:Landroidx/appcompat/widget/ActionBarContainer;

    invoke-virtual {v0, v3}, Landroidx/appcompat/widget/ActionBarContainer;->setVisibility(I)V

    iget v0, p0, La/a/k/g;->d:I

    const/4 v3, 0x0

    if-nez v0, :cond_a

    iget-boolean v0, p0, La/a/k/g;->j:Z

    if-nez v0, :cond_3

    if-eqz p1, :cond_a

    :cond_3
    iget-object v0, p0, La/a/k/g;->b:Landroidx/appcompat/widget/ActionBarContainer;

    invoke-virtual {v0, v3}, Landroid/widget/FrameLayout;->setTranslationY(F)V

    iget-object v0, p0, La/a/k/g;->b:Landroidx/appcompat/widget/ActionBarContainer;

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->getHeight()I

    move-result v0

    neg-int v0, v0

    int-to-float v0, v0

    if-eqz p1, :cond_4

    new-array p1, v1, [I

    fill-array-data p1, :array_0

    iget-object v1, p0, La/a/k/g;->b:Landroidx/appcompat/widget/ActionBarContainer;

    invoke-virtual {v1, p1}, Landroid/widget/FrameLayout;->getLocationInWindow([I)V

    aget p1, p1, v2

    int-to-float p1, p1

    sub-float/2addr v0, p1

    :cond_4
    iget-object p1, p0, La/a/k/g;->b:Landroidx/appcompat/widget/ActionBarContainer;

    invoke-virtual {p1, v0}, Landroid/widget/FrameLayout;->setTranslationY(F)V

    new-instance p1, La/a/o/c;

    invoke-direct {p1}, La/a/o/c;-><init>()V

    iget-object v1, p0, La/a/k/g;->b:Landroidx/appcompat/widget/ActionBarContainer;

    invoke-static {v1}, La/c/i/n;->a(Landroid/view/View;)La/c/i/p;

    move-result-object v1

    invoke-virtual {v1, v3}, La/c/i/p;->f(F)La/c/i/p;

    iget-object v2, p0, La/a/k/g;->m:La/c/i/s;

    invoke-virtual {v1, v2}, La/c/i/p;->e(La/c/i/s;)La/c/i/p;

    .line 2
    iget-boolean v2, p1, La/a/o/c;->e:Z

    if-nez v2, :cond_5

    iget-object v2, p1, La/a/o/c;->a:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 3
    :cond_5
    iget-boolean v1, p0, La/a/k/g;->e:Z

    if-eqz v1, :cond_6

    iget-object v1, p0, La/a/k/g;->c:Landroid/view/View;

    if-eqz v1, :cond_6

    invoke-virtual {v1, v0}, Landroid/view/View;->setTranslationY(F)V

    iget-object v0, p0, La/a/k/g;->c:Landroid/view/View;

    invoke-static {v0}, La/c/i/n;->a(Landroid/view/View;)La/c/i/p;

    move-result-object v0

    invoke-virtual {v0, v3}, La/c/i/p;->f(F)La/c/i/p;

    .line 4
    iget-boolean v1, p1, La/a/o/c;->e:Z

    if-nez v1, :cond_6

    iget-object v1, p1, La/a/o/c;->a:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 5
    :cond_6
    sget-object v0, La/a/k/g;->o:Landroid/view/animation/Interpolator;

    .line 6
    iget-boolean v1, p1, La/a/o/c;->e:Z

    if-nez v1, :cond_7

    iput-object v0, p1, La/a/o/c;->c:Landroid/view/animation/Interpolator;

    .line 7
    :cond_7
    iget-boolean v0, p1, La/a/o/c;->e:Z

    if-nez v0, :cond_8

    iput-wide v4, p1, La/a/o/c;->b:J

    .line 8
    :cond_8
    iget-object v0, p0, La/a/k/g;->l:La/c/i/q;

    .line 9
    iget-boolean v1, p1, La/a/o/c;->e:Z

    if-nez v1, :cond_9

    iput-object v0, p1, La/a/o/c;->d:La/c/i/q;

    .line 10
    :cond_9
    iput-object p1, p0, La/a/k/g;->i:La/a/o/c;

    invoke-virtual {p1}, La/a/o/c;->b()V

    goto :goto_2

    :cond_a
    iget-object p1, p0, La/a/k/g;->b:Landroidx/appcompat/widget/ActionBarContainer;

    invoke-virtual {p1, v6}, Landroid/widget/FrameLayout;->setAlpha(F)V

    iget-object p1, p0, La/a/k/g;->b:Landroidx/appcompat/widget/ActionBarContainer;

    invoke-virtual {p1, v3}, Landroid/widget/FrameLayout;->setTranslationY(F)V

    iget-boolean p1, p0, La/a/k/g;->e:Z

    if-eqz p1, :cond_b

    iget-object p1, p0, La/a/k/g;->c:Landroid/view/View;

    if-eqz p1, :cond_b

    invoke-virtual {p1, v3}, Landroid/view/View;->setTranslationY(F)V

    :cond_b
    iget-object p1, p0, La/a/k/g;->l:La/c/i/q;

    invoke-interface {p1, v7}, La/c/i/q;->a(Landroid/view/View;)V

    :goto_2
    iget-object p1, p0, La/a/k/g;->a:Landroidx/appcompat/widget/ActionBarOverlayLayout;

    if-eqz p1, :cond_16

    invoke-static {p1}, La/c/i/n;->l(Landroid/view/View;)V

    goto/16 :goto_3

    .line 11
    :cond_c
    iget-boolean v0, p0, La/a/k/g;->h:Z

    if-eqz v0, :cond_16

    iput-boolean v3, p0, La/a/k/g;->h:Z

    .line 12
    iget-object v0, p0, La/a/k/g;->i:La/a/o/c;

    if-eqz v0, :cond_d

    invoke-virtual {v0}, La/a/o/c;->a()V

    :cond_d
    iget v0, p0, La/a/k/g;->d:I

    if-nez v0, :cond_15

    iget-boolean v0, p0, La/a/k/g;->j:Z

    if-nez v0, :cond_e

    if-eqz p1, :cond_15

    :cond_e
    iget-object v0, p0, La/a/k/g;->b:Landroidx/appcompat/widget/ActionBarContainer;

    invoke-virtual {v0, v6}, Landroid/widget/FrameLayout;->setAlpha(F)V

    iget-object v0, p0, La/a/k/g;->b:Landroidx/appcompat/widget/ActionBarContainer;

    invoke-virtual {v0, v2}, Landroidx/appcompat/widget/ActionBarContainer;->setTransitioning(Z)V

    new-instance v0, La/a/o/c;

    invoke-direct {v0}, La/a/o/c;-><init>()V

    iget-object v3, p0, La/a/k/g;->b:Landroidx/appcompat/widget/ActionBarContainer;

    invoke-virtual {v3}, Landroid/widget/FrameLayout;->getHeight()I

    move-result v3

    neg-int v3, v3

    int-to-float v3, v3

    if-eqz p1, :cond_f

    new-array p1, v1, [I

    fill-array-data p1, :array_1

    iget-object v1, p0, La/a/k/g;->b:Landroidx/appcompat/widget/ActionBarContainer;

    invoke-virtual {v1, p1}, Landroid/widget/FrameLayout;->getLocationInWindow([I)V

    aget p1, p1, v2

    int-to-float p1, p1

    sub-float/2addr v3, p1

    :cond_f
    iget-object p1, p0, La/a/k/g;->b:Landroidx/appcompat/widget/ActionBarContainer;

    invoke-static {p1}, La/c/i/n;->a(Landroid/view/View;)La/c/i/p;

    move-result-object p1

    invoke-virtual {p1, v3}, La/c/i/p;->f(F)La/c/i/p;

    iget-object v1, p0, La/a/k/g;->m:La/c/i/s;

    invoke-virtual {p1, v1}, La/c/i/p;->e(La/c/i/s;)La/c/i/p;

    .line 13
    iget-boolean v1, v0, La/a/o/c;->e:Z

    if-nez v1, :cond_10

    iget-object v1, v0, La/a/o/c;->a:Ljava/util/ArrayList;

    invoke-virtual {v1, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 14
    :cond_10
    iget-boolean p1, p0, La/a/k/g;->e:Z

    if-eqz p1, :cond_11

    iget-object p1, p0, La/a/k/g;->c:Landroid/view/View;

    if-eqz p1, :cond_11

    invoke-static {p1}, La/c/i/n;->a(Landroid/view/View;)La/c/i/p;

    move-result-object p1

    invoke-virtual {p1, v3}, La/c/i/p;->f(F)La/c/i/p;

    .line 15
    iget-boolean v1, v0, La/a/o/c;->e:Z

    if-nez v1, :cond_11

    iget-object v1, v0, La/a/o/c;->a:Ljava/util/ArrayList;

    invoke-virtual {v1, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 16
    :cond_11
    sget-object p1, La/a/k/g;->n:Landroid/view/animation/Interpolator;

    .line 17
    iget-boolean v1, v0, La/a/o/c;->e:Z

    if-nez v1, :cond_12

    iput-object p1, v0, La/a/o/c;->c:Landroid/view/animation/Interpolator;

    .line 18
    :cond_12
    iget-boolean p1, v0, La/a/o/c;->e:Z

    if-nez p1, :cond_13

    iput-wide v4, v0, La/a/o/c;->b:J

    .line 19
    :cond_13
    iget-object p1, p0, La/a/k/g;->k:La/c/i/q;

    .line 20
    iget-boolean v1, v0, La/a/o/c;->e:Z

    if-nez v1, :cond_14

    iput-object p1, v0, La/a/o/c;->d:La/c/i/q;

    .line 21
    :cond_14
    iput-object v0, p0, La/a/k/g;->i:La/a/o/c;

    invoke-virtual {v0}, La/a/o/c;->b()V

    goto :goto_3

    :cond_15
    iget-object p1, p0, La/a/k/g;->k:La/c/i/q;

    invoke-interface {p1, v7}, La/c/i/q;->a(Landroid/view/View;)V

    :cond_16
    :goto_3
    return-void

    :array_0
    .array-data 4
        0x0
        0x0
    .end array-data

    :array_1
    .array-data 4
        0x0
        0x0
    .end array-data
.end method
