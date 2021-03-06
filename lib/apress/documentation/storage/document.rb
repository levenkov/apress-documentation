require_relative 'base_storage'
require_relative '../dsl/document'

module Apress
  module Documentation
    module Storage
      # Protected
      #
      # Внутренний класс системы документации
      # Описывает отдельный документ
      class Document < BaseStorage
        include Apress::Documentation::Dsl::Document
        # Public: Заголовок документа
        json_attr :title
        # Public: Описание документа
        json_attr :description
        # Public: Бизнесс описание - заполняется менаджером
        json_attr :business_desc
        # Public: Наличие тестов, ссылка на задачу с тестами
        json_attr :tests
        # Public: Публичность описываемого функционала - (Защищенный, Публичный)
        json_attr :publicity

        def initialize(slug)
          @slug = slug
        end

        # Public: проверка, необходимо ли для данного документа отображать SwaggerUI
        def swagger?
          !swagger_documents.empty?
        end

        # Public: Хранит дочерние документы
        def documents
          @documents ||= {}
        end

        # Public: Хранит объекты SwaggerDocument для отображения на одной старнице через SwaggerUI
        def swagger_documents
          @swagger_documents ||= {}
        end

        # Public: находит документ верхнего уровня - модуль
        #
        # Returns Document
        def current_module
          Apress::Documentation::Storage::Modules.instance[slug.to_s.split('/').first]
        end
      end
    end
  end
end
