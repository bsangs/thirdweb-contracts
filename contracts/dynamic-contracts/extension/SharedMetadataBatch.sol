// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.11;

/// @author thirdweb

import "../../lib/NFTMetadataRendererLib.sol";
import "../../extension/interface/ISharedMetadataBatch.sol";
import "../../openzeppelin-presets/utils/EnumerableSet.sol";

/**
 *  @title   Shared Metadata Batch
 *  @notice  Store a batch of shared metadata for NFTs
 */
library SharedMetadataBatchStorage {
    bytes32 public constant SHARED_METADATA_BATCH_STORAGE_POSITION = keccak256("shared.metadata.batch.storage");

    struct Data {
        EnumerableSet.Bytes32Set ids;
        mapping(bytes32 => ISharedMetadataBatch.SharedMetadataWithId) metadata;
    }

    function sharedMetadataBatchStorage() internal pure returns (Data storage sharedMetadataBatchData) {
        bytes32 position = SHARED_METADATA_BATCH_STORAGE_POSITION;
        assembly {
            sharedMetadataBatchData.slot := position
        }
    }
}

abstract contract SharedMetadataBatch is ISharedMetadataBatch {
    using EnumerableSet for EnumerableSet.Bytes32Set;

    /// @notice Set shared metadata for NFTs
    function setSharedMetadata(SharedMetadataInfo calldata metadata, bytes32 _id) external {
        require(_canSetSharedMetadata(), "SharedMetadataBatch: cannot set shared metadata");
        _createSharedMetadata(metadata, _id);
    }

    /// @notice Delete shared metadata for NFTs
    function deleteSharedMetadata(bytes32 _id) external {
        require(_canSetSharedMetadata(), "SharedMetadataBatch: cannot set shared metadata");
        require(_sharedMetadataBatchStorage().ids.remove(_id), "SharedMetadataBatch: shared metadata does not exist");

        delete _sharedMetadataBatchStorage().metadata[_id];

        emit SharedMetadataDeleted(_id);
    }

    /// @notice Get all shared metadata
    function getAllSharedMetadata() external view returns (SharedMetadataWithId[] memory metadata) {
        bytes32[] memory ids = _sharedMetadataBatchStorage().ids.values();
        metadata = new SharedMetadataWithId[](ids.length);

        for (uint256 i = 0; i < ids.length; i += 1) {
            metadata[i] = _sharedMetadataBatchStorage().metadata[ids[i]];
        }
    }

    /// @dev Store shared metadata
    function _createSharedMetadata(SharedMetadataInfo calldata _metadata, bytes32 _id) internal {
        require(_sharedMetadataBatchStorage().ids.add(_id), "SharedMetadataBatch: shared metadata already exists");

        _sharedMetadataBatchStorage().metadata[_id] = SharedMetadataWithId(_id, _metadata);

        emit SharedMetadataUpdated(
            _id,
            _metadata.name,
            _metadata.description,
            _metadata.imageURI,
            _metadata.animationURI
        );
    }

    /// @dev Token URI information getter
    function _getURIFromSharedMetadata(bytes32 id, uint256 tokenId) internal view returns (string memory) {
        SharedMetadataInfo memory info = _sharedMetadataBatchStorage().metadata[id].metadata;

        return
            NFTMetadataRenderer.createMetadataEdition({
                name: info.name,
                description: info.description,
                imageURI: info.imageURI,
                animationURI: info.animationURI,
                tokenOfEdition: tokenId
            });
    }

    /// @dev Get contract storage
    function _sharedMetadataBatchStorage() internal pure returns (SharedMetadataBatchStorage.Data storage data) {
        data = SharedMetadataBatchStorage.sharedMetadataBatchStorage();
    }

    /// @dev Returns whether shared metadata can be set in the given execution context.
    function _canSetSharedMetadata() internal view virtual returns (bool);
}
