describe('Test de Connexion à la plateforme', () => {
  it('passes', () => {
    cy.visit('http://localhost:8000/');
    cy.contains('Connexion').click({ force: true }); //force le clic même si l’élément est invisible ou recouvert (utile si, par exemple, le bouton est caché dans un menu déroulant non ouvert).
    cy.get('input[name="username"]').type('Croix_rouge');
    cy.get('input[name="password"]').type('croixcroix');
    cy.get('button[type="submit"]').click();
    cy.contains('Bienvenue').should('be.visible');
  })

  afterEach(() => {
    cy.contains('Déconnexion').click({ force: true});
    cy.contains('Rejoignez').should('be.visible');
  });
})