require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
    it "sets a new user instance variable" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "#create" do
    context "with valid attributes" do
      def valid_request
        post :create, user: attributes_for(:user)
      end

      it "creates a user record in the database" do
        count_before = User.count
        valid_request
        count_after = User.count
        expect(count_after).to eq(count_before + 1)
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end

      it "sets a session's user_id to the created user id" do
        valid_request
        expect(session[:user_id]).to eq(User.last.id)
      end

      it "redirects to the user page" do
        valid_request
        expect(response).to redirect_to(user_path(session[:user_id]))
      end
    end
  end
end
