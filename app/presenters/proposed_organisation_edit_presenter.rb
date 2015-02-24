class ProposedOrganisationEditPresenter

  def initialize proposed_organisation_edit, usr
    @usr = usr
    @proposed_organisation_edit = proposed_organisation_edit
  end
  
  def can_propose_edit? field
   @proposed_organisation_edit.editable?(field) || @usr.siteadmin? 
  end

end
