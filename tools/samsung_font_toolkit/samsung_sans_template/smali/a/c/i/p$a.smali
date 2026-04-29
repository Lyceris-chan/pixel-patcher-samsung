.class public La/c/i/p$a;
.super Landroid/animation/AnimatorListenerAdapter;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = La/c/i/p;->d(Landroid/view/View;La/c/i/q;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation


# instance fields
.field public final synthetic a:La/c/i/q;

.field public final synthetic b:Landroid/view/View;


# direct methods
.method public constructor <init>(La/c/i/p;La/c/i/q;Landroid/view/View;)V
    .locals 0

    iput-object p2, p0, La/c/i/p$a;->a:La/c/i/q;

    iput-object p3, p0, La/c/i/p$a;->b:Landroid/view/View;

    invoke-direct {p0}, Landroid/animation/AnimatorListenerAdapter;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationCancel(Landroid/animation/Animator;)V
    .locals 1

    iget-object p1, p0, La/c/i/p$a;->a:La/c/i/q;

    iget-object v0, p0, La/c/i/p$a;->b:Landroid/view/View;

    invoke-interface {p1, v0}, La/c/i/q;->b(Landroid/view/View;)V

    return-void
.end method

.method public onAnimationEnd(Landroid/animation/Animator;)V
    .locals 1

    iget-object p1, p0, La/c/i/p$a;->a:La/c/i/q;

    iget-object v0, p0, La/c/i/p$a;->b:Landroid/view/View;

    invoke-interface {p1, v0}, La/c/i/q;->a(Landroid/view/View;)V

    return-void
.end method

.method public onAnimationStart(Landroid/animation/Animator;)V
    .locals 1

    iget-object p1, p0, La/c/i/p$a;->a:La/c/i/q;

    iget-object v0, p0, La/c/i/p$a;->b:Landroid/view/View;

    invoke-interface {p1, v0}, La/c/i/q;->c(Landroid/view/View;)V

    return-void
.end method
