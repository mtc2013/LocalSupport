require 'spec_helper'
describe UsersController do
  describe 'PUT update user-organization status' do
    before(:each) do
      admin_user = double('User', admin?: true)
      request.env['warden'].stub :authenticate! => admin_user
      controller.stub(:current_user).and_return(admin_user)

      @nonadmin_user = double('User', admin?: false, email: 'joetheeskimo@gmail.com', pending_organization_id: 6)
      User.should_receive(:find_by_id).with('4').and_return(@nonadmin_user)
    end
    context 'user requesting pending status to be admin of charity' do
      it 'redirects to the show page for org and flash success' do
        org = double('Organization', name: 'Red Cross')
        Organization.should_receive(:find).and_return(org)
        @nonadmin_user.should_receive(:update_attributes!)

        put :update, id: 4, organization_id: 5
        response.should redirect_to(organization_path(5))
        flash[:notice].should have_content "You have requested admin status for #{org.name}"
      end
    end
    context 'admin promoting user to charity admin' do
      it 'non-admins get refused' do
        controller.stub(:current_user).and_return(@nonadmin_user)
        @nonadmin_user.should_not_receive(:update_attributes!)
        put :update, {:id => '4'}
        response.should redirect_to '/'
      end
      it 'redirects to index page and flash success' do
        @nonadmin_user.should_receive(:update_attributes!)
        put :update, {:id => '4'}
        response.should redirect_to users_path
        flash[:notice].should have_content("You have approved #{@nonadmin_user.email}.")
      end
    end
  end

  describe 'GET index to view pending users' do
    before(:each) do
      @user = double("User")
    end

    context "user signed in" do
      before(:each) do
        controller.stub(:current_user).and_return(@user)
      end

      context "as admin" do
        before(:each) do
          @user.stub(:admin?).and_return(true)
        end

        it "assigns all users to @users" do
          user_double = double("User")
          User.stub(:all).and_return([user_double])
          get :index
          expect(assigns(:users)).to eql([user_double])
        end

        it "renders the index template" do
          get :index
          expect(response).to render_template('index')
        end

        it "renders in full width" do
          get :index
          expect(response).to render_template('layouts/full_width')
        end
      end

      context "as non-admin" do
        before(:each) do
          @user.stub(:admin?).and_return(false)
        end

        it "redirects user to root and flashes a notice" do
          get :index
          response.should redirect_to root_path
        end

        it "flashes the relevant notice" do
          get :index
          expect(flash[:error]).to have_content("You must be signed in as an admin to perform this action!")
        end
      end
    end

    context "user not signed in" do
      before(:each) do
        controller.stub(:current_user).and_return(nil)
      end

      it "redirects user to root" do
        get :index
        response.should redirect_to root_path
      end

      it "flashes the relevant notice" do
        get :index
        expect(flash[:error]).to have_content("You must be signed in as an admin to perform this action!")
      end

    end
  end
end
