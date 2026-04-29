.class public La/c/i/t;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        La/c/i/t$b;,
        La/c/i/t$a;,
        La/c/i/t$c;,
        La/c/i/t$g;,
        La/c/i/t$f;,
        La/c/i/t$e;,
        La/c/i/t$d;,
        La/c/i/t$h;
    }
.end annotation


# static fields
.field public static final b:La/c/i/t;


# instance fields
.field public final a:La/c/i/t$h;


# direct methods
.method public static constructor <clinit>()V
    .locals 2

    .line 1
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    if-lt v0, v1, :cond_0

    new-instance v0, La/c/i/t$b;

    invoke-direct {v0}, La/c/i/t$b;-><init>()V

    goto :goto_0

    :cond_0
    const/16 v1, 0x14

    if-lt v0, v1, :cond_1

    new-instance v0, La/c/i/t$a;

    invoke-direct {v0}, La/c/i/t$a;-><init>()V

    goto :goto_0

    :cond_1
    new-instance v0, La/c/i/t$c;

    invoke-direct {v0}, La/c/i/t$c;-><init>()V

    .line 2
    :goto_0
    invoke-virtual {v0}, La/c/i/t$c;->a()La/c/i/t;

    move-result-object v0

    .line 3
    iget-object v0, v0, La/c/i/t;->a:La/c/i/t$h;

    invoke-virtual {v0}, La/c/i/t$h;->a()La/c/i/t;

    move-result-object v0

    .line 4
    iget-object v0, v0, La/c/i/t;->a:La/c/i/t$h;

    invoke-virtual {v0}, La/c/i/t$h;->b()La/c/i/t;

    move-result-object v0

    .line 5
    iget-object v0, v0, La/c/i/t;->a:La/c/i/t$h;

    invoke-virtual {v0}, La/c/i/t$h;->c()La/c/i/t;

    move-result-object v0

    .line 6
    sput-object v0, La/c/i/t;->b:La/c/i/t;

    return-void
.end method

.method public constructor <init>(La/c/i/t;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance p1, La/c/i/t$h;

    invoke-direct {p1, p0}, La/c/i/t$h;-><init>(La/c/i/t;)V

    iput-object p1, p0, La/c/i/t;->a:La/c/i/t$h;

    return-void
.end method

.method public constructor <init>(Landroid/view/WindowInsets;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1d

    if-lt v0, v1, :cond_0

    new-instance v0, La/c/i/t$g;

    invoke-direct {v0, p0, p1}, La/c/i/t$g;-><init>(La/c/i/t;Landroid/view/WindowInsets;)V

    goto :goto_0

    :cond_0
    const/16 v1, 0x1c

    if-lt v0, v1, :cond_1

    new-instance v0, La/c/i/t$f;

    invoke-direct {v0, p0, p1}, La/c/i/t$f;-><init>(La/c/i/t;Landroid/view/WindowInsets;)V

    goto :goto_0

    :cond_1
    const/16 v1, 0x15

    if-lt v0, v1, :cond_2

    new-instance v0, La/c/i/t$e;

    invoke-direct {v0, p0, p1}, La/c/i/t$e;-><init>(La/c/i/t;Landroid/view/WindowInsets;)V

    goto :goto_0

    :cond_2
    const/16 v1, 0x14

    if-lt v0, v1, :cond_3

    new-instance v0, La/c/i/t$d;

    invoke-direct {v0, p0, p1}, La/c/i/t$d;-><init>(La/c/i/t;Landroid/view/WindowInsets;)V

    :goto_0
    iput-object v0, p0, La/c/i/t;->a:La/c/i/t$h;

    goto :goto_1

    :cond_3
    new-instance p1, La/c/i/t$h;

    invoke-direct {p1, p0}, La/c/i/t$h;-><init>(La/c/i/t;)V

    iput-object p1, p0, La/c/i/t;->a:La/c/i/t$h;

    :goto_1
    return-void
.end method

.method public static f(La/c/e/b;IIII)La/c/e/b;
    .locals 5

    iget v0, p0, La/c/e/b;->a:I

    sub-int/2addr v0, p1

    const/4 v1, 0x0

    invoke-static {v1, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    iget v2, p0, La/c/e/b;->b:I

    sub-int/2addr v2, p2

    invoke-static {v1, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    iget v3, p0, La/c/e/b;->c:I

    sub-int/2addr v3, p3

    invoke-static {v1, v3}, Ljava/lang/Math;->max(II)I

    move-result v3

    iget v4, p0, La/c/e/b;->d:I

    sub-int/2addr v4, p4

    invoke-static {v1, v4}, Ljava/lang/Math;->max(II)I

    move-result v1

    if-ne v0, p1, :cond_0

    if-ne v2, p2, :cond_0

    if-ne v3, p3, :cond_0

    if-ne v1, p4, :cond_0

    return-object p0

    :cond_0
    invoke-static {v0, v2, v3, v1}, La/c/e/b;->a(IIII)La/c/e/b;

    move-result-object p0

    return-object p0
.end method

.method public static h(Landroid/view/WindowInsets;)La/c/i/t;
    .locals 1

    new-instance v0, La/c/i/t;

    if-eqz p0, :cond_0

    invoke-direct {v0, p0}, La/c/i/t;-><init>(Landroid/view/WindowInsets;)V

    return-object v0

    :cond_0
    const/4 p0, 0x0

    .line 1
    throw p0
.end method


# virtual methods
.method public a()I
    .locals 1

    invoke-virtual {p0}, La/c/i/t;->e()La/c/e/b;

    move-result-object v0

    iget v0, v0, La/c/e/b;->d:I

    return v0
.end method

.method public b()I
    .locals 1

    invoke-virtual {p0}, La/c/i/t;->e()La/c/e/b;

    move-result-object v0

    iget v0, v0, La/c/e/b;->a:I

    return v0
.end method

.method public c()I
    .locals 1

    invoke-virtual {p0}, La/c/i/t;->e()La/c/e/b;

    move-result-object v0

    iget v0, v0, La/c/e/b;->c:I

    return v0
.end method

.method public d()I
    .locals 1

    invoke-virtual {p0}, La/c/i/t;->e()La/c/e/b;

    move-result-object v0

    iget v0, v0, La/c/e/b;->b:I

    return v0
.end method

.method public e()La/c/e/b;
    .locals 1

    iget-object v0, p0, La/c/i/t;->a:La/c/i/t$h;

    invoke-virtual {v0}, La/c/i/t$h;->f()La/c/e/b;

    move-result-object v0

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 1

    if-ne p0, p1, :cond_0

    const/4 p1, 0x1

    return p1

    :cond_0
    instance-of v0, p1, La/c/i/t;

    if-nez v0, :cond_1

    const/4 p1, 0x0

    return p1

    :cond_1
    check-cast p1, La/c/i/t;

    iget-object v0, p0, La/c/i/t;->a:La/c/i/t$h;

    iget-object p1, p1, La/c/i/t;->a:La/c/i/t$h;

    .line 1
    invoke-static {v0, p1}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public g()Landroid/view/WindowInsets;
    .locals 2

    iget-object v0, p0, La/c/i/t;->a:La/c/i/t$h;

    instance-of v1, v0, La/c/i/t$d;

    if-eqz v1, :cond_0

    check-cast v0, La/c/i/t$d;

    iget-object v0, v0, La/c/i/t$d;->b:Landroid/view/WindowInsets;

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return-object v0
.end method

.method public hashCode()I
    .locals 1

    iget-object v0, p0, La/c/i/t;->a:La/c/i/t$h;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, La/c/i/t$h;->hashCode()I

    move-result v0

    :goto_0
    return v0
.end method
