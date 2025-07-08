describe('Premier Test', () => {
  it('devra seulement tester ce code et accéder au lien', () => {
    cy.visit('http://localhost:8000/')
    cy.screenshot();
  })
})