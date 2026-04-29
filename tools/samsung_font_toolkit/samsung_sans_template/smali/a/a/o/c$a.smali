.class public La/a/o/c$a;
.super La/c/i/r;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = La/a/o/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation


# instance fields
.field public a:Z

.field public b:I

.field public final synthetic c:La/a/o/c;


# direct methods
.method public constructor <init>(La/a/o/c;)V
    .locals 0

    iput-object p1, p0, La/a/o/c$a;->c:La/a/o/c;

    invoke-direct {p0}, La/c/i/r;-><init>()V

    const/4 p1, 0x0

    iput-boolean p1, p0, La/a/o/c$a;->a:Z

    iput p1, p0, La/a/o/c$a;->b:I

    return-void
.end method


# virtual methods
.method public a(Landroid/view/View;)V
    .locals 1

    iget p1, p0, La/a/o/c$a;->b:I

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, La/a/o/c$a;->b:I

    iget-object v0, p0, La/a/o/c$a;->c:La/a/o/c;

    iget-object v0, v0, La/a/o/c;->a:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ne p1, v0, :cond_1

    iget-object p1, p0, La/a/o/c$a;->c:La/a/o/c;

    iget-object p1, p1, La/a/o/c;->d:La/c/i/q;

    if-eqz p1, :cond_0

    const/4 v0, 0x0

    invoke-interface {p1, v0}, La/c/i/q;->a(Landroid/view/View;)V

    :cond_0
    const/4 p1, 0x0

    .line 1
    iput p1, p0, La/a/o/c$a;->b:I

    iput-boolean p1, p0, La/a/o/c$a;->a:Z

    iget-object v0, p0, La/a/o/c$a;->c:La/a/o/c;

    .line 2
    iput-boolean p1, v0, La/a/o/c;->e:Z

    :cond_1
    return-void
.end method

.method public c(Landroid/view/View;)V
    .locals 1

    iget-boolean p1, p0, La/a/o/c$a;->a:Z

    if-eqz p1, :cond_0

    return-void

    :cond_0
    const/4 p1, 0x1

    iput-boolean p1, p0, La/a/o/c$a;->a:Z

    iget-object p1, p0, La/a/o/c$a;->c:La/a/o/c;

    iget-object p1, p1, La/a/o/c;->d:La/c/i/q;

    if-eqz p1, :cond_1

    const/4 v0, 0x0

    invoke-interface {p1, v0}, La/c/i/q;->c(Landroid/view/View;)V

    :cond_1
    return-void
.end method
