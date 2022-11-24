//
//  FishSpeciesTests.swift
//  FishSpeciesTests
//
//  Created by MacBook Pro on 22/11/22.
//

import XCTest
@testable import FishSpecies

class FishSpeciesTests: XCTestCase {
    
    var observer: NSKeyValueObservation?
    
    var viewModel = FishListViewModel(fishSpeciesService: MockService())
    let detailViewModel = FishDetailViewModel()
    
    var listVC: FishListViewController!
    var detailVC: FishDetailViewController!
    
    override func setUp() {
        super.setUp()
        listVC = makeSUT()
        detailVC = makeDetailPageSUT()
    }
    
    func makeSUT() -> FishListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(identifier: "FishListViewController") as? FishListViewController
        sut?.viewModel = viewModel
        sut?.loadViewIfNeeded()
        sut?.viewDidLoad()
        return sut ?? FishListViewController()
    }
    
    func makeDetailPageSUT() -> FishDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(identifier: "FishDetailViewController") as? FishDetailViewController
        sut?.viewModel = detailViewModel
        sut?.loadViewIfNeeded()
        sut?.viewDidLoad()
        return sut ?? FishDetailViewController()
    }
    
    func testNavigationItemTitle() {
        XCTAssertEqual(listVC.navigationItem.title, "Fish Species")
    }
    
    func testNumberofRows() {
        XCTAssertTrue(self.listVC.viewModel.getNumberofRows() > 0)
    }
    
    func testNumberOfRows() {
        let numberOfRows = listVC.tableView(listVC.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, listVC.viewModel.getNumberofRows(), "Number of rows in table should match")
    }
    
    func testTableViewHasCells() {
        let cell = listVC.tableView.dequeueReusableCell(withIdentifier: FishListCell.identifier)
        XCTAssertNotNil(cell, "TableView should be able to dequeue cell with identifier: '\(FishListCell.identifier)'")
    }
    
    func testHasATableView() {
        XCTAssertNotNil(listVC.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(listVC.tableView.delegate)
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(listVC.tableView.dataSource)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(listVC.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(listVC.responds(to: #selector(listVC.tableView(_:didSelectRowAt:))))
        XCTAssertTrue(listVC.responds(to: #selector(listVC.tableView(_:heightForRowAt:))))
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(listVC.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(listVC.responds(to: #selector(listVC.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(listVC.responds(to: #selector(listVC.tableView(_:cellForRowAt:))))
    }
    
    func testTableViewCellHasReuseIdentifier() {
        let cell = listVC.tableView(listVC.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? FishListCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = FishListCell.identifier
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    
    func testTableCellHasCorrectLabelText() {
        let indexPath0 = IndexPath(row: 0, section: 0)
        let cell0 = listVC.tableView(listVC.tableView, cellForRowAt: indexPath0) as? FishListCell
        XCTAssertEqual(cell0?.scientificNameLabel.text, listVC.viewModel.getFishSpecies(at: indexPath0).scientificName)
        let indexPath1 = IndexPath(row: 1, section: 0)
        let cell1 = listVC.tableView(listVC.tableView, cellForRowAt: indexPath1) as? FishListCell
        XCTAssertEqual(cell1?.scientificNameLabel.text, listVC.viewModel.getCellViewModel(at: indexPath1).scientificName)
        let indexPath2 = IndexPath(row: 2, section: 0)
        let cell2 = listVC.tableView(listVC.tableView, cellForRowAt: indexPath2) as? FishListCell
        XCTAssertEqual(cell2?.scientificNameLabel.text, listVC.viewModel.getCellViewModel(at: indexPath2).scientificName)
    }
    
    func testDidSelectAction() {
        listVC.tableView(listVC.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
    
    func testDetailPageDataLoading() {
        let fishSpeciesDetail = listVC.viewModel.getFishSpecies(at: IndexPath(row: 0, section: 0))
        detailVC.viewModel.fishSpeciesDetail = fishSpeciesDetail
        XCTAssertEqual(detailVC.viewModel.detailPageViewModel?.imageUrlStr, fishSpeciesDetail.speciesIllustrationPhoto?.src)
    }
    
    func testDeviceIsJailBroken() {
        XCTAssertNotNil(UIDevice.current.isJailBroken())
    }
    
    func testAPIWorking() {
        let expectation = XCTestExpectation.init(description: "Fish Species Service expectation")
        let fishSpeciesService: FishSpeciesServiceProtocol = FishService()
        fishSpeciesService.getFishSpecies { success, results, error in
            if error != nil {
                XCTFail("Fail")
            }
            if success, let fishSpecies = results {
                if !fishSpecies.isEmpty {
                    expectation.fulfill()
                }
            } else {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testMockAPIWorking() {
        let expectation = XCTestExpectation.init(description: "Fish Species Mock Service expectation")
        let fishSpeciesService: FishSpeciesServiceProtocol = MockService()
        fishSpeciesService.getFishSpecies { success, results, error in
            if error != nil {
                XCTFail("Fail")
            }
            if success, let fishSpecies = results {
                if !fishSpecies.isEmpty {
                    expectation.fulfill()
                }
            } else {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testJailBrokenHelper() {
        XCTAssertNotNil(UIDevice.current.isJailBroken())
        XCTAssertNotNil(JailBrokenHelper.hasCydiaInstalled())
        XCTAssertNotNil(JailBrokenHelper.isContainsSuspiciousApps())
        XCTAssertNotNil(JailBrokenHelper.isSuspiciousSystemPathsExists())
        XCTAssertNotNil(JailBrokenHelper.canEditSystemFiles())
    }

    func testImageDownloading() {
        let fishImageView = UIImageView()
        let imageURLStr = "https://origin-east-01-drupal-fishwatch.woc.noaa.gov/sites/default/files/Pink_snapper_NB_W_0.png"
        fishImageView.loadImageUsingCache(withUrl: imageURLStr)
        observer = fishImageView.observe(\.image, options: [.old, .new], changeHandler: {(imageView, _) in
            XCTAssertNotNil(imageView.image)
        })

        let fishImageViewOne = UIImageView()
        fishImageViewOne.loadImageUsingCache(withUrl: imageURLStr)
        XCTAssertEqual(fishImageView.image, fishImageViewOne.image)
    }
    
    func testImageGalleryObjInModel() {
        let expectation = XCTestExpectation.init(description: "Fish Species Mock Service expectation")
        let fishSpeciesService: FishSpeciesServiceProtocol = MockService()
        fishSpeciesService.getFishSpecies { success, results, error in
            if error != nil {
                XCTFail("Fail")
            }
            if success, let fishSpecies = results {
                if !fishSpecies.isEmpty {
                    let firstObject = fishSpecies.first?.imageGallery?.values
                    if let firstObjectNotNil =  firstObject, !firstObjectNotNil.isEmpty {
                        expectation.fulfill()
                    }
                    expectation.fulfill()
                }
            } else {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)

    }
    
    func testAttriutedString() {
        let htmlText = "<a href=\"/species-aliases/opakapaka\" property=\"rdfs:label skos:prefLabel\" datatype=\"\">Opakapaka</a>"
        XCTAssertNotNil(htmlText.htmlToAttributedString)
    }
}
