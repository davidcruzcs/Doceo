package com.juandavidcruz.doceo;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

/**
 * Created by JuanCruz on 9/7/16.
 */
public class KnowledgeHubFragment extends Fragment {
    /**
     * The fragment argument representing the section number for this
     * fragment.
     */
    private static final String ARG_SECTION_NUMBER = "section_number";


    public KnowledgeHubFragment() {
    }

    public static DiscoverFragment newInstance(int sectionNumber) {
        DiscoverFragment fragment = new DiscoverFragment();
        Bundle args = new Bundle();
        args.putInt(ARG_SECTION_NUMBER, sectionNumber);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_main, container, false);
        TextView textView = (TextView) rootView.findViewById(R.id.section_label);
        textView.setText("KnowledgeFragment");
        return rootView;
    }
}
