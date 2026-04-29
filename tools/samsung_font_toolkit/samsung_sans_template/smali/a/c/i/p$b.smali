.class public La/c/i/p$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Landroid/animation/ValueAnimator$AnimatorUpdateListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = La/c/i/p;->e(La/c/i/s;)La/c/i/p;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation


# instance fields
.field public final synthetic a:La/c/i/s;

.field public final synthetic b:Landroid/view/View;


# direct methods
.method public constructor <init>(La/c/i/p;La/c/i/s;Landroid/view/View;)V
    .locals 0

    iput-object p2, p0, La/c/i/p$b;->a:La/c/i/s;

    iput-object p3, p0, La/c/i/p$b;->b:Landroid/view/View;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationUpdate(Landroid/animation/ValueAnimator;)V
    .locals 0

    iget-object p1, p0, La/c/i/p$b;->a:La/c/i/s;

    check-cast p1, La/a/k/g$a;

    .line 1
    iget-object p1, p1, La/a/k/g$a;->a:La/a/k/g;

    iget-object p1, p1, La/a/k/g;->b:Landroidx/appcompat/widget/ActionBarContainer;

    invoke-virtual {p1}, Landroid/widget/FrameLayout;->getParent()Landroid/view/ViewParent;

    move-result-object p1

    check-cast p1, Landroid/view/View;

    invoke-virtual {p1}, Landroid/view/View;->invalidate()V

    return-void
.end method
