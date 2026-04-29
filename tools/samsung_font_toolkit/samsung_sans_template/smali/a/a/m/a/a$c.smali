.class public La/a/m/a/a$c;
.super La/a/m/a/d$a;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = La/a/m/a/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "c"
.end annotation


# instance fields
.field public K:La/b/c;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "La/b/c<",
            "Ljava/lang/Long;",
            ">;"
        }
    .end annotation
.end field

.field public L:La/b/g;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "La/b/g<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(La/a/m/a/a$c;La/a/m/a/a;Landroid/content/res/Resources;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, La/a/m/a/d$a;-><init>(La/a/m/a/d$a;La/a/m/a/d;Landroid/content/res/Resources;)V

    if-eqz p1, :cond_0

    iget-object p2, p1, La/a/m/a/a$c;->K:La/b/c;

    iput-object p2, p0, La/a/m/a/a$c;->K:La/b/c;

    iget-object p1, p1, La/a/m/a/a$c;->L:La/b/g;

    goto :goto_0

    :cond_0
    new-instance p1, La/b/c;

    invoke-direct {p1}, La/b/c;-><init>()V

    iput-object p1, p0, La/a/m/a/a$c;->K:La/b/c;

    new-instance p1, La/b/g;

    const/16 p2, 0xa

    .line 1
    invoke-direct {p1, p2}, La/b/g;-><init>(I)V

    .line 2
    :goto_0
    iput-object p1, p0, La/a/m/a/a$c;->L:La/b/g;

    return-void
.end method

.method public static i(II)J
    .locals 2

    int-to-long v0, p0

    const/16 p0, 0x20

    shl-long/2addr v0, p0

    int-to-long p0, p1

    or-long/2addr p0, v0

    return-wide p0
.end method


# virtual methods
.method public e()V
    .locals 1

    iget-object v0, p0, La/a/m/a/a$c;->K:La/b/c;

    invoke-virtual {v0}, La/b/c;->b()La/b/c;

    move-result-object v0

    iput-object v0, p0, La/a/m/a/a$c;->K:La/b/c;

    iget-object v0, p0, La/a/m/a/a$c;->L:La/b/g;

    invoke-virtual {v0}, La/b/g;->b()La/b/g;

    move-result-object v0

    iput-object v0, p0, La/a/m/a/a$c;->L:La/b/g;

    return-void
.end method

.method public h(IILandroid/graphics/drawable/Drawable;Z)I
    .locals 9

    invoke-super {p0, p3}, La/a/m/a/b$c;->a(Landroid/graphics/drawable/Drawable;)I

    move-result p3

    invoke-static {p1, p2}, La/a/m/a/a$c;->i(II)J

    move-result-wide v0

    if-eqz p4, :cond_0

    const-wide v2, 0x200000000L

    goto :goto_0

    :cond_0
    const-wide/16 v2, 0x0

    :goto_0
    iget-object v4, p0, La/a/m/a/a$c;->K:La/b/c;

    int-to-long v5, p3

    or-long v7, v5, v2

    invoke-static {v7, v8}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v7

    invoke-virtual {v4, v0, v1, v7}, La/b/c;->a(JLjava/lang/Object;)V

    if-eqz p4, :cond_1

    invoke-static {p2, p1}, La/a/m/a/a$c;->i(II)J

    move-result-wide p1

    iget-object p4, p0, La/a/m/a/a$c;->K:La/b/c;

    const-wide v0, 0x100000000L

    or-long/2addr v0, v5

    or-long/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-virtual {p4, p1, p2, v0}, La/b/c;->a(JLjava/lang/Object;)V

    :cond_1
    return p3
.end method

.method public j(I)I
    .locals 2

    const/4 v0, 0x0

    if-gez p1, :cond_0

    goto :goto_0

    :cond_0
    iget-object v1, p0, La/a/m/a/a$c;->L:La/b/g;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v1, p1, v0}, La/b/g;->d(ILjava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result v0

    :goto_0
    return v0
.end method

.method public k([I)I
    .locals 0

    invoke-super {p0, p1}, La/a/m/a/d$a;->g([I)I

    move-result p1

    if-ltz p1, :cond_0

    return p1

    :cond_0
    sget-object p1, Landroid/util/StateSet;->WILD_CARD:[I

    invoke-super {p0, p1}, La/a/m/a/d$a;->g([I)I

    move-result p1

    return p1
.end method

.method public newDrawable()Landroid/graphics/drawable/Drawable;
    .locals 2

    new-instance v0, La/a/m/a/a;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, La/a/m/a/a;-><init>(La/a/m/a/a$c;Landroid/content/res/Resources;)V

    return-object v0
.end method

.method public newDrawable(Landroid/content/res/Resources;)Landroid/graphics/drawable/Drawable;
    .locals 1

    new-instance v0, La/a/m/a/a;

    invoke-direct {v0, p0, p1}, La/a/m/a/a;-><init>(La/a/m/a/a$c;Landroid/content/res/Resources;)V

    return-object v0
.end method
