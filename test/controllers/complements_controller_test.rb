require 'test_helper'

class ComplementsControllerTest < ActionController::TestCase
  setup do
    @complement = complements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:complements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create complement" do
    assert_difference('Complement.count') do
      post :create, complement: { badge_name: @complement.badge_name, cpf: @complement.cpf, je_id: @complement.je_id, name: @complement.name, photo: @complement.photo, rg: @complement.rg, user_id: @complement.user_id }
    end

    assert_redirected_to complement_path(assigns(:complement))
  end

  test "should show complement" do
    get :show, id: @complement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @complement
    assert_response :success
  end

  test "should update complement" do
    patch :update, id: @complement, complement: { badge_name: @complement.badge_name, cpf: @complement.cpf, je_id: @complement.je_id, name: @complement.name, photo: @complement.photo, rg: @complement.rg, user_id: @complement.user_id }
    assert_redirected_to complement_path(assigns(:complement))
  end

  test "should destroy complement" do
    assert_difference('Complement.count', -1) do
      delete :destroy, id: @complement
    end

    assert_redirected_to complements_path
  end
end
