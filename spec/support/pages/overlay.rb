class CardOverlay < PageFragment
  def dismiss
    all('.close-overlay').first.click
  end

  def assignee
    find('#task_assignee_id_chosen').text
  end

  def assignee=(name)
    select_from_chosen name, from: 'Assignee'
  end

  def title
    find('main > h1').text
  end

  def body
    find('main > p').text
  end

  def mark_as_complete
    find('footer input[type="checkbox"]').click
  end

  def completed?
    find('footer input[type="checkbox"]').checked?
  end

  def view_paper
    old_position = session.evaluate_script "$('header a').css('position')"
    session.execute_script "$('header a').css('position', 'relative')"
    find('header h2 a').click
    session.execute_script "$('header a').css('position', '#{old_position}')"
    PaperPage.new
  end
end
