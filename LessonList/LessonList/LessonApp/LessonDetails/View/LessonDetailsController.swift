//
//  LessonDetailsController.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 04/01/2023.
//


import UIKit
import LinkPresentation
import Combine
import AVKit

class LessonDetailsController: BaseViewController {
    
    let videoDownloader = VideoDownloader()
    let viewModel = LessonDetailsViewModel()
    var lessonListViewModel: LessonListViewModel? = nil
    let metaProvider = LPMetadataProvider()
    var lessonList: (lesson: StoredLessonModel, arrayOfLesson: [StoredLessonModel], totalCount: Int, currentCount: Int)?
    var currentCount = 0
    var lessonVideo: String = ""
    var totalCount = 0
    var arrayOfLesson = [StoredLessonModel]()
    var updateDownloadButton: Bool = false
    var savedID = [Int]()
    var isNextLessonClicked: Bool = false
    var isPreviousLessonClicked: Bool = false
    var indexNox = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        savedID = viewModel.alreadyDownloadedID
        configureView()
        unwrapObjects()
        onButtonTap()
      
        view.backgroundColor = UIColor(named: "BlackColor")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDownloadButton = UserDefaults.standard.bool(forKey: "downloadedState")
        setUpNavigationBar()
        updateUIAfterDownLoad()
    }
    
    lazy var lessonView: UIView = {
        let lessonView = UIView()
        lessonView.contentMode = .scaleAspectFill
        lessonView.clipsToBounds = true
        return lessonView
    }()
    
    lazy var lpLessonView: LPLinkView = {
        let lessonView = LPLinkView()
        lessonView.contentMode = .scaleAspectFill
        lessonView.clipsToBounds = true
        return lessonView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var downloadButton: UIButton = {
        var downloadButton = UIButton()
        downloadButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
        downloadButton.setTitle("Download", for: .normal)
        downloadButton.tintColor = .systemBlue
        downloadButton.setTitleColor(.systemBlue, for: .normal)
        return downloadButton
    }()
    
    let lessonLabel = Label(text: "", font: .productSansBold(size: 25), textColor: .white, alignment: .center)
    
    let lessonOverview = Label(text: "", font: .productSansRegular(size: 17), textColor: .white, alignment: .center)
    
    let nextLessonButton: Button = {
        let nextLessonButton = Button(btnTitle: "Next Lesson", btnTextColor: .systemBlue, btnBackgroundColor: .clear, buttonImage: "chevron.right", edgeInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20))
        nextLessonButton.semanticContentAttribute = .forceRightToLeft
        return nextLessonButton
    }()
    
    let previousLessonButton: Button = {
        let previousLessonButton = Button(btnTitle: "Prev Lesson", btnTextColor: .systemBlue, btnBackgroundColor: .clear, buttonImage: "chevron.left", edgeInset: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
        previousLessonButton.semanticContentAttribute = .forceLeftToRight
        return previousLessonButton
    }()
    
    let cancelButton: Button = {
        let cancelButton = Button(btnTitle: "Cancel", btnTextColor: .red, btnBackgroundColor: .clear, buttonImage: "", edgeInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        return cancelButton
    }()
    
    let backButton: Button = {
        let backButton = Button(btnTitle: "Lessons", btnTextColor: .systemBlue, btnBackgroundColor: .clear, buttonImage: "chevron.left", edgeInset: nil)
        return backButton
    }()
    
    override func configureViews() {
        super.configureViews()
        view.addSubviews(lessonView, lpLessonView, stackView)
        stackView.addSubviews(lessonLabel, lessonOverview, nextLessonButton, previousLessonButton)
        
        lessonView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, size: CGSize(height: 250))
        
        lpLessonView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, size: CGSize(height: 250))
        
        stackView.anchor(top: lessonView.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, margin: UIEdgeInsets(allEdges: 20))
        
        lessonLabel.anchor(top: stackView.topAnchor, leading: stackView.leadingAnchor, trailing: stackView.trailingAnchor, margin: .init(top: 20, left: 10, bottom: 10, right: 10))
        
        lessonOverview.anchor(top: lessonLabel.bottomAnchor, leading: stackView.leadingAnchor, trailing: stackView.trailingAnchor, margin: .init(top: 20, left: 10, bottom: 10, right: 15))
        
        nextLessonButton.anchor(top: lessonOverview.bottomAnchor, trailing: stackView.trailingAnchor, margin: .init(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: 140, height: 40))
        
        previousLessonButton.anchor(top: lessonOverview.bottomAnchor, leading: stackView.leadingAnchor, margin: .init(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: 140, height: 40))
    }
    
    @objc func cancelDownload() {
        updateCancelButton(int: Int(lessonList?.lesson.id ?? 0))
    }
    
    func updateCancelButton(int: Int) {
        cancelButton.isHidden = true
        if videoDownloader.cancelDownload() {
            self.downloadButton.setTitle(self.viewModel.isDownloaded(id: int), for: .normal)
        }
    }
    
    private func setUpNavigationBar() {
        DispatchQueue.main.async {
            self.parent?.navigationItem.rightBarButtonItem = self.addNavBarButton(button: self.downloadButton, width: 150)
            self.parent?.navigationItem.titleView = self.cancelButton
            self.cancelButton.isHidden = true
        }
    }
    
    private func configureView() {
        show_hide_Button()
        viewTapGesture(view: lessonView)
        viewTapGesture(view: lpLessonView)
        videoDownloader.model = lessonList?.lesson
        updateUIAfterDownLoad()
    }
    
    func onButtonTap() {
        downloadButton.addTarget(self, action: #selector(DidDownloadLessonVideo), for: .touchUpInside)
        nextLessonButton.addTarget(self, action: #selector(clickNextLessonButton), for: .touchUpInside)
        previousLessonButton.addTarget(self, action: #selector(clickPreviousLessonButton), for: .touchUpInside)
        self.downloadButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
        self.downloadButton.setTitle(self.viewModel.isDownloaded(id: Int(lessonList?.lesson.id ?? 0)), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelDownload), for: .touchUpInside)
    }
    
    func viewTapGesture(view: UIView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
    }
    
    private func unwrapObjects() {
        if let lessonList {
            totalCount = lessonList.totalCount
            arrayOfLesson = lessonList.arrayOfLesson
            lessonVideo = lessonList.lesson.videoUrl ?? ""
            currentCount = lessonList.currentCount
            initializeView(with: lessonList.lesson)
        }
    }
    
    func initializeView(with data: StoredLessonModel) {
        lessonLabel.text = data.name
        lessonOverview.text = data.descriptions
        lessonView.isHidden = true
        self.showLoading()
        playVideoCache(url: data.videoUrl ?? "")
        updateUIAfterDownLoad()
    }
    
    func playVideoCache(url: String) {
        if let url = URL(string: url) {
            VideoCache.shared.load(url: url as NSURL) {[weak self] data in
                DispatchQueue.main.async {
                    if let data {
                        self?.lpLessonView.metadata = data
                        self?.hideLoading()
                        self?.lessonView.isHidden = false
                    }
                }
            }
        }
    }
    
    func updateUIAfterDownLoad() {
        self.downloadButton.setTitle(self.viewModel.isDownloaded(id: Int(lessonList?.lesson.id ?? 0)), for: .normal)
    }
    
    func show_hide_Button() {
        if let lessonList {
            initializeView(with: lessonList.lesson)
            
            if lessonList.currentCount != 0 {
                previousLessonButton.isHidden = false
            } else {
                previousLessonButton.isHidden = true
            }
            
            if lessonList.currentCount+1 != lessonList.totalCount {
                nextLessonButton.isHidden = false
            } else {
                nextLessonButton.isHidden = true
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
