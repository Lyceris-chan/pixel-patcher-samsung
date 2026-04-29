.class public La/c/g/b$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements La/c/g/c$c;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = La/c/g/b;->c(Landroid/content/Context;La/c/g/a;La/c/d/b/g;Landroid/os/Handler;ZII)Landroid/graphics/Typeface;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "La/c/g/c$c<",
        "La/c/g/b$g;",
        ">;"
    }
.end annotation


# instance fields
.field public final synthetic a:La/c/d/b/g;

.field public final synthetic b:Landroid/os/Handler;


# direct methods
.method public constructor <init>(La/c/d/b/g;Landroid/os/Handler;)V
    .locals 0

    iput-object p1, p0, La/c/g/b$b;->a:La/c/d/b/g;

    iput-object p2, p0, La/c/g/b$b;->b:Landroid/os/Handler;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/Object;)V
    .locals 2

    check-cast p1, La/c/g/b$g;

    if-nez p1, :cond_0

    .line 1
    iget-object p1, p0, La/c/g/b$b;->a:La/c/d/b/g;

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    iget v0, p1, La/c/g/b$g;->b:I

    if-nez v0, :cond_1

    iget-object v0, p0, La/c/g/b$b;->a:La/c/d/b/g;

    iget-object p1, p1, La/c/g/b$g;->a:Landroid/graphics/Typeface;

    iget-object v1, p0, La/c/g/b$b;->b:Landroid/os/Handler;

    invoke-virtual {v0, p1, v1}, La/c/d/b/g;->b(Landroid/graphics/Typeface;Landroid/os/Handler;)V

    goto :goto_1

    :cond_1
    iget-object p1, p0, La/c/g/b$b;->a:La/c/d/b/g;

    :goto_0
    iget-object v1, p0, La/c/g/b$b;->b:Landroid/os/Handler;

    invoke-virtual {p1, v0, v1}, La/c/d/b/g;->a(ILandroid/os/Handler;)V

    :goto_1
    return-void
.end method
