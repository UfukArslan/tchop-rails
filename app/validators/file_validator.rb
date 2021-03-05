class FileValidator < ActiveModel::EachValidator

    def validate_each(record, attribute, value)
        if value 
            # vérifie s'il s'agit d'un fichier
            if value.respond_to? :path 
                # si on a un fichier et qu'on a un path, 
                #   on vérifie l'extension, sans le point (.jpg -> jpg) 
                unless options[:ext].include? File.extname(value.path).delete('.').to_sym
                    record.errors[attribute] << "is not a valid file (#{options[:ext].join(',')})"
                end

            else
                # s'il ne s'agit pas d'un fichier, on passe un message reçu en 
                #   paramètre. Si aucun message, message par défaut. 
                record.errors[attribute] << (options[:message] || 'is not a file')
            end 
        end 
    end 
end
