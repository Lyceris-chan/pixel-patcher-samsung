.class public La/c/i/t$c;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = La/c/i/t;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "c"
.end annotation


# instance fields
.field public final a:La/c/i/t;


# direct methods
.method public constructor <init>()V
    .locals 2

    new-instance v0, La/c/i/t;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, La/c/i/t;-><init>(La/c/i/t;)V

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object v0, p0, La/c/i/t$c;->a:La/c/i/t;

    return-void
.end method

.method public constructor <init>(La/c/i/t;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, La/c/i/t$c;->a:La/c/i/t;

    return-void
.end method


# virtual methods
.method public a()La/c/i/t;
    .locals 1

    iget-object v0, p0, La/c/i/t$c;->a:La/c/i/t;

    return-object v0
.end method

.method public b(La/c/e/b;)V
    .locals 0

    return-void
.end method

.method public c(La/c/e/b;)V
    .locals 0

    return-void
.end method
