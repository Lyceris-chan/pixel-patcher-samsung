.class public La/c/i/t$g;
.super La/c/i/t$f;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = La/c/i/t;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "g"
.end annotation


# direct methods
.method public constructor <init>(La/c/i/t;Landroid/view/WindowInsets;)V
    .locals 0

    invoke-direct {p0, p1, p2}, La/c/i/t$f;-><init>(La/c/i/t;Landroid/view/WindowInsets;)V

    return-void
.end method


# virtual methods
.method public g(IIII)La/c/i/t;
    .locals 1

    iget-object v0, p0, La/c/i/t$d;->b:Landroid/view/WindowInsets;

    invoke-virtual {v0, p1, p2, p3, p4}, Landroid/view/WindowInsets;->inset(IIII)Landroid/view/WindowInsets;

    move-result-object p1

    invoke-static {p1}, La/c/i/t;->h(Landroid/view/WindowInsets;)La/c/i/t;

    move-result-object p1

    return-object p1
.end method
