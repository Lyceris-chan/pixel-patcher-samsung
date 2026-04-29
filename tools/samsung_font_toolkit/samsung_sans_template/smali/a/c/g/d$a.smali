.class public La/c/g/d$a;
.super Ljava/lang/Object;
.source ""

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = La/c/g/d;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation


# instance fields
.field public final synthetic b:Ljava/lang/Object;

.field public final synthetic c:La/c/g/d;


# direct methods
.method public constructor <init>(La/c/g/d;Ljava/lang/Object;)V
    .locals 0

    iput-object p1, p0, La/c/g/d$a;->c:La/c/g/d;

    iput-object p2, p0, La/c/g/d$a;->b:Ljava/lang/Object;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, La/c/g/d$a;->c:La/c/g/d;

    iget-object v0, v0, La/c/g/d;->d:La/c/g/c$c;

    iget-object v1, p0, La/c/g/d$a;->b:Ljava/lang/Object;

    invoke-interface {v0, v1}, La/c/g/c$c;->a(Ljava/lang/Object;)V

    return-void
.end method
