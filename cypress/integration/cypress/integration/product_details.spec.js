describe('Jungle App', () => {
 
  beforeEach(() => {
    cy.visit("/");
    cy.get('article')
    .eq(0)
    .click()
  })
  
  it("There is product details on the page", () => {
    cy.get("article.product-detail").should("be.visible");
  });

})