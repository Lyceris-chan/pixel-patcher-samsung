.class public La/a/p/s$b;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = La/a/p/s;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "b"
.end annotation


# instance fields
.field public final synthetic b:La/a/p/s;


# direct methods
.method public constructor <init>(La/a/p/s;)V
    .locals 0

    iput-object p1, p0, La/a/p/s$b;->b:La/a/p/s;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, La/a/p/s$b;->b:La/a/p/s;

    const/4 v1, 0x0

    iput-object v1, v0, La/a/p/s;->o:La/a/p/s$b;

    invoke-virtual {v0}, La/a/p/s;->drawableStateChanged()V

    return-void
.end method
