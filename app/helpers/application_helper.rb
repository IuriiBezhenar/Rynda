module ApplicationHelper

  # return a title on a per-page basic
  def title
    Const::STR_MSG_APPLICATION_TITLE + (@title.nil? ? "" : "|#{@title}")
  end

  def logo
    image_tag(Const::STR_VALUE_LOGO_IMAGE_FILE_NAME,
              :alt => Const::STR_MSG_APPLICATION_TITLE, :class => "round")
  end

  def export_xls
    image_tag(Const::STR_VALUE_XLS_IMAGE_FILE_NAME,
              :alt => Const::STR_MSG_EXPORT_XLS, :class => "round")
  end

  def image_checked
    image_tag(Const::STR_VALUE_CHECK_IMAGE_FILE_NAME,
              :alt => '+', :class => "round")
  end

end
