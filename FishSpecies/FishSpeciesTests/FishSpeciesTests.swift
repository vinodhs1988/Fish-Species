//
//  FishSpeciesTests.swift
//  FishSpeciesTests
//
//  Created by MacBook Pro on 22/11/22.
//

import XCTest
@testable import FishSpecies

class FishSpeciesTests: XCTestCase {
    
    var viewModel = HomeViewModel(fishSpeciesService: MockService())
    
    var vc: HomeViewController!
    
    override func setUp() {
        super.setUp()
        vc = makeSUT()
    }
    
    func makeSUT() -> HomeViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        sut.viewModel = viewModel
        sut.loadViewIfNeeded()
        sut.viewDidLoad()
        sut.initView()
        sut.initViewModel()
        return sut
    }
    
    
    func testNavigationItemTitle() {
        XCTAssertEqual(vc.navigationItem.title, "Fish Species")
    }
    
    func testNumberofRows() {
        XCTAssertTrue(self.vc.viewModel.getNumberofRows() > 0)
    }
    
    func testNumberOfRows() {
        let numberOfRows = vc.tableView(vc.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, vc.viewModel.getNumberofRows(), "Number of rows in table should match number of fish species")
    }
    
    
    func testTableViewHasCells() {
        let cell = vc.tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier)
        XCTAssertNotNil(cell, "TableView should be able to dequeue cell with identifier: '\(HomeCell.identifier)'")
    }
    
    func testHasATableView() {
        XCTAssertNotNil(vc.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(vc.tableView.delegate)
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(vc.tableView.dataSource)
    }


    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(vc.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(vc.responds(to: #selector(vc.tableView(_:didSelectRowAt:))))
        XCTAssertTrue(vc.responds(to: #selector(vc.tableView(_:heightForRowAt:))))
    }

    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(vc.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(vc.responds(to: #selector(vc.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(vc.responds(to: #selector(vc.tableView(_:cellForRowAt:))))
    }

    func testTableViewCellHasReuseIdentifier() {
        let cell = vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? HomeCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = HomeCell.identifier
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }

    func testTableCellHasCorrectLabelText() {
        let cell0 = vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? HomeCell
        XCTAssertEqual(cell0?.scientificNameLabel.text, vc.viewModel.getFishSpecies(at: IndexPath(row: 0, section: 0)).scientificName)
        
        let cell1 = vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 1, section: 0)) as? HomeCell
        XCTAssertEqual(cell1?.scientificNameLabel.text, vc.viewModel.getCellViewModel(at: IndexPath(row: 1, section: 0)).scientificName)

        let cell2 = vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 2, section: 0)) as? HomeCell
        XCTAssertEqual(cell2?.scientificNameLabel.text, vc.viewModel.getCellViewModel(at: IndexPath(row: 2, section: 0)).scientificName)
    }

    func testDidSelectAction(){
        vc.tableView(vc.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
}
