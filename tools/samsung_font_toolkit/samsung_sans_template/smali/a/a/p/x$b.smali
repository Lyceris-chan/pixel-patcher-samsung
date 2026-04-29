.class public La/a/p/x$b;
.super Landroid/database/DataSetObserver;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = La/a/p/x;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "b"
.end annotation


# instance fields
.field public final synthetic a:La/a/p/x;


# direct methods
.method public constructor <init>(La/a/p/x;)V
    .locals 0

    iput-object p1, p0, La/a/p/x$b;->a:La/a/p/x;

    invoke-direct {p0}, Landroid/database/DataSetObserver;-><init>()V

    return-void
.end method


# virtual methods
.method public onChanged()V
    .locals 1

    iget-object v0, p0, La/a/p/x$b;->a:La/a/p/x;

    invoke-virtual {v0}, La/a/p/x;->b()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, La/a/p/x$b;->a:La/a/p/x;

    invoke-virtual {v0}, La/a/p/x;->h()V

    :cond_0
    return-void
.end method

.method public onInvalidated()V
    .locals 1

    iget-object v0, p0, La/a/p/x$b;->a:La/a/p/x;

    invoke-virtual {v0}, La/a/p/x;->d()V

    return-void
.end method
