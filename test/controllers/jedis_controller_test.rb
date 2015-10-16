require 'test_helper'

class JedisControllerTest < ActionController::TestCase
  setup do
    @jedi = jedis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jedis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jedi" do
    assert_difference('Jedi.count') do
      post :create, jedi: { age: @jedi.age, name: @jedi.name }
    end

    assert_redirected_to jedi_path(assigns(:jedi))
  end

  test "should show jedi" do
    get :show, id: @jedi
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @jedi
    assert_response :success
  end

  test "should update jedi" do
    patch :update, id: @jedi, jedi: { age: @jedi.age, name: @jedi.name }
    assert_redirected_to jedi_path(assigns(:jedi))
  end

  test "should destroy jedi" do
    assert_difference('Jedi.count', -1) do
      delete :destroy, id: @jedi
    end

    assert_redirected_to jedis_path
  end
end
