.class public La/c/g/b$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/util/concurrent/Callable;


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
        "Ljava/util/concurrent/Callable<",
        "La/c/g/b$g;",
        ">;"
    }
.end annotation


# instance fields
.field public final synthetic a:Landroid/content/Context;

.field public final synthetic b:La/c/g/a;

.field public final synthetic c:I

.field public final synthetic d:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/content/Context;La/c/g/a;ILjava/lang/String;)V
    .locals 0

    iput-object p1, p0, La/c/g/b$a;->a:Landroid/content/Context;

    iput-object p2, p0, La/c/g/b$a;->b:La/c/g/a;

    iput p3, p0, La/c/g/b$a;->c:I

    iput-object p4, p0, La/c/g/b$a;->d:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public call()Ljava/lang/Object;
    .locals 4

    .line 1
    iget-object v0, p0, La/c/g/b$a;->a:Landroid/content/Context;

    iget-object v1, p0, La/c/g/b$a;->b:La/c/g/a;

    iget v2, p0, La/c/g/b$a;->c:I

    invoke-static {v0, v1, v2}, La/c/g/b;->b(Landroid/content/Context;La/c/g/a;I)La/c/g/b$g;

    move-result-object v0

    iget-object v1, v0, La/c/g/b$g;->a:Landroid/graphics/Typeface;

    if-eqz v1, :cond_0

    sget-object v2, La/c/g/b;->a:La/b/d;

    iget-object v3, p0, La/c/g/b$a;->d:Ljava/lang/String;

    invoke-virtual {v2, v3, v1}, La/b/d;->b(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_0
    return-object v0
.end method
