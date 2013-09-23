require 'application_helpers'
require 'timesheet_exhibit'
include ApplicationHelpers

describe ApplicationHelpers do
  describe 'exhibit helper' do
    context 'when given a Timesheet, a context and a format' do
      let( :activity         ){ double( 'activity' ).as_null_object }
      let( :month            ){ double( 'month'    ).as_null_object }
      let( :timesheet        ){ Timesheet.new activity, month       }
      let( :context          ){ double( 'context', settings: context_settings ).as_null_object }
      let( :context_settings ){ double( 'settings', root: '.' )     }

      it 'returns a TimesheetExhibit object' do
        exhibit( timesheet, format: 'default', context: context ).to be_kind_of TimesheetExhibit
      end
    end
    context 'when given a Fact' do
      it 'returns a FactExhibit object'
    end
  end
end
