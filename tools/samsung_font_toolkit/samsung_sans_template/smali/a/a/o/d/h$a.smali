.class public La/a/o/d/h$a;
.super La/c/i/b;
.source ""


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = La/a/o/d/h;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "a"
.end annotation


# instance fields
.field public final b:Landroid/view/ActionProvider;

.field public final synthetic c:La/a/o/d/h;


# direct methods
.method public constructor <init>(La/a/o/d/h;Landroid/content/Context;Landroid/view/ActionProvider;)V
    .locals 0

    iput-object p1, p0, La/a/o/d/h$a;->c:La/a/o/d/h;

    invoke-direct {p0, p2}, La/c/i/b;-><init>(Landroid/content/Context;)V

    iput-object p3, p0, La/a/o/d/h$a;->b:Landroid/view/ActionProvider;

    return-void
.end method
