require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # assert u.save => assegure que foi salvo
  # assert !u.save => assegure que NAO foi salvo

  test "deveria salvar um usuário valido no banco" do
    u = User.new(:login => "teste", :password => "senha")
    assert u.save, "Usuario válido deveria ser salvo."

    # tirando o usuario da memoria
    u = nil
    u = User.find_by_login("teste")
    assert_not_nil u, "Usuario válido não foi gravado no banco."
  end

  test "não deveria salvar usuario com login invalido" do
    checa_se_login_invalido("", "vazio")
    checa_se_login_invalido(nil, "nulo")
    checa_se_login_invalido("e", "com apenas um caractere")
    checa_se_login_invalido("e" * 256, "com mais de 250 caracteres")
    checa_se_login_invalido("    ", "só com espaços em branco")
    checa_se_login_invalido(" xx ", "com espaços em branco ao redor")
  end

  test "deveria autenticar um usuario valido" do
    u = User.authenticate(:login => "pedro", :password => "senha_pedro")
    assert_equal 0, u.errors.size, "autenticação deveria ter aceito usuario"
  end

  test "não deveria autenticar com usuario ou senha inválidos" do
    u = User.authenticate(:login => "pedro", :password => "senha errada")
    assert u.errors.size > 0, "não deveria aceitar usuario com senha invalida"

    u = User.authenticate(:login => "usuario errado", :password => "senha_pedro")
    assert u.errors.size > 0, "não deveria aceitar usuario com login invalido"
  end

  test "a senha deve ser encriptada no banco de dados" do
    u  = User.new(:login => "novo_user", :password => "123456")
    assert u.save, "Usuario deveria ser salvo"

    u = User.find_by_login("novo_user")
    assert_nil u.password, "senha não esta nula"
    assert u.password_hash != "123456", "senha não foi encriptada"
  end

  test "teste algoritimo de encriptação" do
    assert_equal User.encrypt("qualquer_texto"), User.encrypt("qualquer_texto")
    assert "qualquer texto" != User.encrypt("qualquer texto")
  end

  def checa_se_login_invalido(login, mensagem)
    u = User.new(:login => login, :password => "senha")
    assert !u.save, "não deveria salvar o usuario com login #{mensagem}"
  end

end
