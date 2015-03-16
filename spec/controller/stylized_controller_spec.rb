require 'rails_helper'
require 'stylized_controller'
# require_relative '../support/wordpress_layout'

class FoosController < SaasStylist::StylizedController; end

describe FoosController, type: :controller do
  render_views

  controller(FoosController) do
    def index
      render text: 'Hello World'
    end
  end

  before { get :index }
  it 'creates anonymous controller derived from FoosController' do
    # expect(controller).to be_a_kind_of(FoosController)

    it_behaves_like 'rendering into wordpress template'
  end
end
