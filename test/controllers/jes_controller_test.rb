require 'test_helper'

class JesControllerTest < ActionController::TestCase
  setup do
    @je = jes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create je" do
    assert_difference('Je.count') do
      post :create, je: { name: @je.name }
    end

    assert_redirected_to je_path(assigns(:je))
  end

  test "should show je" do
    get :show, id: @je
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @je
    assert_response :success
  end

  test "should update je" do
    patch :update, id: @je, je: { name: @je.name }
    assert_redirected_to je_path(assigns(:je))
  end

  test "should destroy je" do
    assert_difference('Je.count', -1) do
      delete :destroy, id: @je
    end

    assert_redirected_to jes_path
  end
end
