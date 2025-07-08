describe('Test des Missions', () => {
  it('Ensemble de tests pour la partie missions du projet', () => {
    cy.visit('http://localhost:8000/');
    cy.screenshot();
    cy.get('nav').contains('Notifications').click({ force: true});
    cy.screenshot();
    cy.contains('Connexion').click({ force: true }); //force le clic même si l’élément est invisible ou recouvert (utile si, par exemple, le bouton est caché dans un menu déroulant non ouvert).
    cy.get('input[name="username"]').type('Croix_rouge');
    cy.get('input[name="password"]').type('croixcroix');
    cy.get('button[type="submit"]').click();
    cy.contains('Bienvenue').should('be.visible');
    //cy.get('p').contains('Bonjour').should('have.text', 'Bonjour Croix_rouge!');
    cy.wait(250);
    cy.screenshot();

    cy.get('nav').contains('Missions').click({ force: true });
    cy.contains('Liste').should('be.visible');
    cy.get('input[name="urgent"]').check();
    cy.contains('Filtrer').click({ force: true });
    cy.screenshot();

    cy.contains('tr', 'Distribution de colis').contains('Modifier').click();
    cy.contains('Modifier la Mission').should('be.visible');
    cy.screenshot();
    cy.contains('Retour').click();

    cy.get('nav').contains('Statistiques').click({ force: true});
    cy.get('h2').contains('Statistiques').should('be.visible');
    cy.screenshot();
  })

  after(() => {
    cy.contains('Déconnexion').click({ force: true});
    cy.contains('Rejoignez').should('be.visible');
    cy.screenshot();
  });
})