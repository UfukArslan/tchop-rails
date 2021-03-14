class User < ApplicationRecord
  attr_accessor :avatar_file

  has_secure_password
  has_secure_token :confirmation_token

  # après avoir sauvegarder, on upload l'image de l'avatar (voir plus bas)
  # after_save :avatar_after_upload

  # supprime l'avatar en cas de supression du user.
  # after_destroy_commit :avatar_destroy

  # avant de sauver, on vérifie que le chemin de l'image existe et
  # si c'est le cas, on met à 'true' le champ avatar
  # before_save :avatar_before_upload

  validates :username,
    format: {with: /\A[a-zA-Z0-9_]{2,20}\z/, message: "uniquement caractères alphanumériques ou _"},
    uniqueness: {case_sensitive: false}

  validates :email,
    format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/},
    uniqueness: {case_sensitive: false}

  validates :avatar_file, file: {ext: [:jpg, :png]}

  # converti un user en session, pour ensuite utiliser :
  # -> session[:auth] = @user.to_session
  def to_session
    {id: id}
  end

  def avatar_path
    File.join(
      Rails.public_path,
      self.class.name.downcase.pluralize,
      id.to_s,
      "avatar.jpg"
    )
  end

  def avatar_url
    "/" + [
      self.class.name.downcase.pluralize,
      id.to_s,
      "avatar.jpg"
    ].join("/")
  end

  private

  # vérifie si le chemin de l'image est bon, si oui, on met avatar à true
  def avatar_before_upload
    if avatar_file.respond_to? :path
      self.avatar = true
    end
  end

  def avatar_destroy
    dir = File.dirname(avatar_path)
    FileUtils.rm_r(dir) if Dir.exist?(dir)
  end

  # utilise la librarie mini_magick pour redimensionner les images
  #  nécessite d'avoir  ImageMagick installé.
  #  -> non fonctionnel actuellement.
  def avatar_after_upload
    # File.join -> concataine les dossiers d'un chemin
    # self.class retourne 'user', qu'on met en minuscule et au pluriel
    #  -> but, sauver le fichier dans un dossier '/public/users/id/avatar.jpg'
    path = avatar_path

    # une fois le chemin créé, on vérifie si le chemin existe, sinon on le crée
    if avatar_file.respond_to? :path
      dir = File.dirname(path)
      FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
      FileUtils.cp(avatar_file.path, path)
      image = MiniMagick::Image.new(avatar_file.path) do |b|
        b.resize "150x150^"
        b.gravity "Center"
        b.crop "150x150+0+0"
      end
      image.format "jpg"
      image.write path
    end
  end
end
