.class public La/a/p/z;
.super La/a/p/x;
.source ""

# interfaces
.implements La/a/p/y;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        La/a/p/z$a;
    }
.end annotation


# static fields
.field public static H:Ljava/lang/reflect/Method;


# instance fields
.field public G:La/a/p/y;


# direct methods
.method public static constructor <clinit>()V
    .locals 5

    :try_start_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-gt v0, v1, :cond_0

    const-class v0, Landroid/widget/PopupWindow;

    const-string v1, "setTouchModal"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Class;

    const/4 v3, 0x0

    sget-object v4, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v4, v2, v3

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, La/a/p/z;->H:Ljava/lang/reflect/Method;
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const-string v0, "MenuPopupWindow"

    const-string v1, "Could not find method setTouchModal() on PopupWindow. Oh well."

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    :goto_0
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V
    .locals 0

    const/4 p2, 0x0

    invoke-direct {p0, p1, p2, p3, p4}, La/a/p/x;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V

    return-void
.end method


# virtual methods
.method public a(La/a/o/d/f;Landroid/view/MenuItem;)V
    .locals 1

    iget-object v0, p0, La/a/p/z;->G:La/a/p/y;

    if-eqz v0, :cond_0

    invoke-interface {v0, p1, p2}, La/a/p/y;->a(La/a/o/d/f;Landroid/view/MenuItem;)V

    :cond_0
    return-void
.end method

.method public e(La/a/o/d/f;Landroid/view/MenuItem;)V
    .locals 1

    iget-object v0, p0, La/a/p/z;->G:La/a/p/y;

    if-eqz v0, :cond_0

    invoke-interface {v0, p1, p2}, La/a/p/y;->e(La/a/o/d/f;Landroid/view/MenuItem;)V

    :cond_0
    return-void
.end method

.method public f(Landroid/content/Context;Z)La/a/p/s;
    .locals 1

    new-instance v0, La/a/p/z$a;

    invoke-direct {v0, p1, p2}, La/a/p/z$a;-><init>(Landroid/content/Context;Z)V

    invoke-virtual {v0, p0}, La/a/p/z$a;->setHoverListener(La/a/p/y;)V

    return-object v0
.end method
