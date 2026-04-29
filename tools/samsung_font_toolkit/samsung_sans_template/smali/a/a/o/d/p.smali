.class public La/a/o/d/p;
.super La/a/o/d/f;
.source ""

# interfaces
.implements Landroid/view/SubMenu;


# instance fields
.field public A:La/a/o/d/f;

.field public B:La/a/o/d/g;


# direct methods
.method public constructor <init>(Landroid/content/Context;La/a/o/d/f;La/a/o/d/g;)V
    .locals 0

    invoke-direct {p0, p1}, La/a/o/d/f;-><init>(Landroid/content/Context;)V

    iput-object p2, p0, La/a/o/d/p;->A:La/a/o/d/f;

    iput-object p3, p0, La/a/o/d/p;->B:La/a/o/d/g;

    return-void
.end method


# virtual methods
.method public d(La/a/o/d/g;)Z
    .locals 1

    iget-object v0, p0, La/a/o/d/p;->A:La/a/o/d/f;

    invoke-virtual {v0, p1}, La/a/o/d/f;->d(La/a/o/d/g;)Z

    move-result p1

    return p1
.end method

.method public e(La/a/o/d/f;Landroid/view/MenuItem;)Z
    .locals 1

    invoke-super {p0, p1, p2}, La/a/o/d/f;->e(La/a/o/d/f;Landroid/view/MenuItem;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, La/a/o/d/p;->A:La/a/o/d/f;

    invoke-virtual {v0, p1, p2}, La/a/o/d/f;->e(La/a/o/d/f;Landroid/view/MenuItem;)Z

    move-result p1

    if-eqz p1, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 p1, 0x1

    :goto_1
    return p1
.end method

.method public f(La/a/o/d/g;)Z
    .locals 1

    iget-object v0, p0, La/a/o/d/p;->A:La/a/o/d/f;

    invoke-virtual {v0, p1}, La/a/o/d/f;->f(La/a/o/d/g;)Z

    move-result p1

    return p1
.end method

.method public getItem()Landroid/view/MenuItem;
    .locals 1

    iget-object v0, p0, La/a/o/d/p;->B:La/a/o/d/g;

    return-object v0
.end method

.method public j()La/a/o/d/f;
    .locals 1

    iget-object v0, p0, La/a/o/d/p;->A:La/a/o/d/f;

    invoke-virtual {v0}, La/a/o/d/f;->j()La/a/o/d/f;

    move-result-object v0

    return-object v0
.end method

.method public l()Z
    .locals 1

    iget-object v0, p0, La/a/o/d/p;->A:La/a/o/d/f;

    invoke-virtual {v0}, La/a/o/d/f;->l()Z

    move-result v0

    return v0
.end method

.method public m()Z
    .locals 1

    iget-object v0, p0, La/a/o/d/p;->A:La/a/o/d/f;

    invoke-virtual {v0}, La/a/o/d/f;->m()Z

    move-result v0

    return v0
.end method

.method public n()Z
    .locals 1

    iget-object v0, p0, La/a/o/d/p;->A:La/a/o/d/f;

    invoke-virtual {v0}, La/a/o/d/f;->n()Z

    move-result v0

    return v0
.end method

.method public setGroupDividerEnabled(Z)V
    .locals 1

    iget-object v0, p0, La/a/o/d/p;->A:La/a/o/d/f;

    invoke-virtual {v0, p1}, La/a/o/d/f;->setGroupDividerEnabled(Z)V

    return-void
.end method

.method public setHeaderIcon(I)Landroid/view/SubMenu;
    .locals 6

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move v3, p1

    .line 1
    invoke-virtual/range {v0 .. v5}, La/a/o/d/f;->u(ILjava/lang/CharSequence;ILandroid/graphics/drawable/Drawable;Landroid/view/View;)V

    return-object p0
.end method

.method public setHeaderIcon(Landroid/graphics/drawable/Drawable;)Landroid/view/SubMenu;
    .locals 6

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v4, p1

    .line 2
    invoke-virtual/range {v0 .. v5}, La/a/o/d/f;->u(ILjava/lang/CharSequence;ILandroid/graphics/drawable/Drawable;Landroid/view/View;)V

    return-object p0
.end method

.method public setHeaderTitle(I)Landroid/view/SubMenu;
    .locals 6

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move v1, p1

    .line 1
    invoke-virtual/range {v0 .. v5}, La/a/o/d/f;->u(ILjava/lang/CharSequence;ILandroid/graphics/drawable/Drawable;Landroid/view/View;)V

    return-object p0
.end method

.method public setHeaderTitle(Ljava/lang/CharSequence;)Landroid/view/SubMenu;
    .locals 6

    const/4 v1, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v2, p1

    .line 2
    invoke-virtual/range {v0 .. v5}, La/a/o/d/f;->u(ILjava/lang/CharSequence;ILandroid/graphics/drawable/Drawable;Landroid/view/View;)V

    return-object p0
.end method

.method public setHeaderView(Landroid/view/View;)Landroid/view/SubMenu;
    .locals 6

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v0, p0

    move-object v5, p1

    .line 1
    invoke-virtual/range {v0 .. v5}, La/a/o/d/f;->u(ILjava/lang/CharSequence;ILandroid/graphics/drawable/Drawable;Landroid/view/View;)V

    return-object p0
.end method

.method public setIcon(I)Landroid/view/SubMenu;
    .locals 1

    iget-object v0, p0, La/a/o/d/p;->B:La/a/o/d/g;

    invoke-virtual {v0, p1}, La/a/o/d/g;->setIcon(I)Landroid/view/MenuItem;

    return-object p0
.end method

.method public setIcon(Landroid/graphics/drawable/Drawable;)Landroid/view/SubMenu;
    .locals 1

    iget-object v0, p0, La/a/o/d/p;->B:La/a/o/d/g;

    invoke-virtual {v0, p1}, La/a/o/d/g;->setIcon(Landroid/graphics/drawable/Drawable;)Landroid/view/MenuItem;

    return-object p0
.end method

.method public setQwertyMode(Z)V
    .locals 1

    iget-object v0, p0, La/a/o/d/p;->A:La/a/o/d/f;

    invoke-virtual {v0, p1}, La/a/o/d/f;->setQwertyMode(Z)V

    return-void
.end method
