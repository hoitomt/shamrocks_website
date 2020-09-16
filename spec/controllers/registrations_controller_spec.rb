require 'rails_helper'

RSpec.describe RegistrationsController do
  it 'get new' do
    get :new
    expect(response).to have_http_status(:success)
  end

  describe 'create new registration' do
    let(:good_params) {
      {
        player_first_name: 'Lebron',
        player_last_name: 'James',
        need_uniform: false,
        parent_first_name: 'Magic',
        parent_last_name: 'Johnson',
        email: 'magic_man@lakers.com',
        grade_level: 4
      }
    }

    it 'creates a new registration' do
      expect {
        post :create, params: { registration: good_params }
      }.to change{Registration.count}.by(1)
    end

    it 'requires a first name' do
      post :create, params: { registration: {last_name: 'bad request'} }
      expect(assigns(:registration).errors.messages.keys).to include(:player_first_name)
    end
  end
end
