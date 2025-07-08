describe("Test d'inscription à la plateforme", () => {
  it('passes', () => {
    cy.visit('http://localhost:8000/inscription/');
    //cy.visit('');
    //cy.contains('inscription').click({ force: true });
    cy.get('input[name="username"]').type('test');
    cy.get('input[name="email"]').type('test@example.com');
    cy.get('input[name="type_utilisateur"]').check('association');
    cy.get('input[name="password1"]').type('sofacsofac');
    cy.get('input[name="password2"]').type('sofacsofac');
    cy.get('button[type="submit"]').click();
  })
})