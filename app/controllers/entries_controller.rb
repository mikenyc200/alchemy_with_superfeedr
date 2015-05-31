class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :destroy, :analysis]

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all
  end

  def filter_by_concepts

    @entries = Entry.all
    entries_ids = Entry.all.pluck(:id)

    if !params["sentiment"].blank?
      @entries =  Entry.where(:id => entries_ids).where("sentiment_score > ?" , params[:sentiment])
      entries_ids = @entries.pluck(:id)
    end

    if !params["concept"].blank?
      @entries = Entry.where(:id => entries_ids).where(:id => Concept.where(:text => params["concept"]).pluck(:entry_id))
      entries_ids = @entries.pluck(:id)
    end

    if !params["text"].blank?
      @entries = Entry.where(:id => entries_ids).where("extracted_text like ?" , "%#{params["text"]}%")
    end


    #if params["text"].blank? and !params["concept"].blank? and params["sentiment"].blank?
    #  @entries = Entry.where(:id => Concept.where(:text => params["concept"]).pluck(:entry_id))
    #elsif params["concept"].blank? and !params["text"].blank?  and params["sentiment"].blank?
    #  @entries = Entry.where("extracted_text like ?" , "%#{params["text"]}%")
    #elsif !params["concept"].blank? and !params["text"].blank?  and params["sentiment"].blank?
    #  @entries = Entry.where("extracted_text like ?" ,  "%#{params["text"]}%"  ).where(:id => Concept.where(:text => params["concept"]).pluck(:entry_id))
    #
    #elsif params["concept"].blank? and params["text"].blank? and !params["sentiment"].blank?
    #
    #else
    #  @entries = Entry.all
    #end

  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def analysis

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_entry
    @entry = Entry.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def entry_params
    params.require(:entry).permit(:feed_id, :atom_id, :title, :url, :content)
  end
end
