require 'test_helper'

class PadawansControllerTest < ActionController::TestCase
  setup do
    @padawan = padawans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:padawans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create padawan" do
    assert_difference('Padawan.count') do
      post :create, padawan: { age: @padawan.age, name: @padawan.name }
    end

    assert_redirected_to padawan_path(assigns(:padawan))
  end

  test "should show padawan" do
    get :show, id: @padawan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @padawan
    assert_response :success
  end

  test "should update padawan" do
    patch :update, id: @padawan, padawan: { age: @padawan.age, name: @padawan.name }
    assert_redirected_to padawan_path(assigns(:padawan))
  end

  test "should destroy padawan" do
    assert_difference('Padawan.count', -1) do
      delete :destroy, id: @padawan
    end

    assert_redirected_to padawans_path
  end
end
