.class public La/a/o/d/d$d;
.super Ljava/lang/Object;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = La/a/o/d/d;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "d"
.end annotation


# instance fields
.field public final a:La/a/p/z;

.field public final b:La/a/o/d/f;

.field public final c:I


# direct methods
.method public constructor <init>(La/a/p/z;La/a/o/d/f;I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, La/a/o/d/d$d;->a:La/a/p/z;

    iput-object p2, p0, La/a/o/d/d$d;->b:La/a/o/d/f;

    iput p3, p0, La/a/o/d/d$d;->c:I

    return-void
.end method
